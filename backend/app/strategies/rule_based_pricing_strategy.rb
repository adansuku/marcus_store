class RuleBasedPricingStrategy < PricingStrategy
  def calculate
    base_price = @product.base_price || 0

    # Get all parts options via product_parts
    available_part_options = @product.product_parts.includes(:part_options).flat_map(&:part_options)

    # Add the price adjustments of the selected options
    options_price = @selected_options.sum(&:price)

    # Apply additional pricing rules
    extra_price = @selected_options.sum do |option|
      available_part_options
        .select { |p_option| p_option == option }
        .sum { |p_option| p_option.pricing_rules.where(dependent_part_option: @selected_options).sum(:price) }
    end

    base_price + options_price + extra_price
  end
end
