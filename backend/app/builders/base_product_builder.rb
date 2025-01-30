class BaseProductBuilder
  attr_reader :product, :errors

  def initialize(product)
    @product = product
    @errors = []
  end

  def build
    raise NotImplementedError, 'You must implement the build method in a subclass'
  end

  def validate
    @errors.clear
    validate_product_type
    apply_restrictions if errors.empty?
    errors.empty?
  end

  private

  def validate_product_type

    unless valid_product_type?(product.product_type)
      errors << "Invalid product type: #{product.product_type}"
    end
  end

  def apply_restrictions
    raise NotImplementedError, 'You must implement apply_restrictions in a subclass'
  end
end
