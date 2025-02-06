class PartProductBuilder < BaseProductBuilder
  attr_reader :total_price

  def initialize(product, pricing_strategy = RuleBasedPricingStrategy.new(product, []))
    super(product)
    @selected_part_options = []
    @pricing_strategy = pricing_strategy
    @total_price = 0
  end

  def build(parts_with_options)
    parts_with_options.each do |part_data|
      part = Part.find_by(name: part_data[:name])
      raise "Part #{part_data[:name]} not found" unless part

      process_part_options(part, part_data[:options])
    end

    apply_restrictions
    calculate_price
  end

  def validate
    @errors.clear
    validate_required_parts_present(@selected_part_options) if @selected_part_options
    apply_restrictions if @selected_part_options.any? { |option| option.restrictions.present? }
    errors.empty?
  end

  private

  def validate_required_parts_present(parts_with_options)
    # Get required parts
    required_parts = @product.product_parts.where(required: true).includes(:part).pluck(:'parts.name')

    # Get parts provided by the user with options selected
    provided_parts = parts_with_options.map(&:part)

    # Verify if all required parts are present
    missing_parts = required_parts - provided_parts.map(&:name)
    missing_parts.each do |part_name|
      errors << "Part #{part_name} is required but not provided"
    end
  end

  def process_part_options(part, options)
    options.each do |option_data|
      option = part.part_options.find_by(name: option_data[:name])
      raise "Option #{option_data[:name]} not found for Part #{part.name}" unless option

      @selected_part_options << option
    end
  end

  def apply_restrictions
    false unless @selected_part_options.any? { |option| option.restrictions.present? }

    @selected_part_options.each do |source_option|
      source_option.restrictions.each do |restriction|
        validate_restriction(restriction, source_option)
      end
    end
  end

  def validate_restriction(restriction, source_option)
    target = restriction.target_part_option
    if restriction.excludes? && @selected_part_options.include?(target)
      errors << "Option #{source_option.name} cannot be combined with #{target.name}"
    elsif restriction.requires? && !@selected_part_options.include?(target)
      errors << "Option #{source_option.name} requires #{target.name}"
    end
  end

  def calculate_price
    @pricing_strategy = @pricing_strategy.class.new(product, @selected_part_options)
    @total_price = @pricing_strategy.calculate
  end

end
