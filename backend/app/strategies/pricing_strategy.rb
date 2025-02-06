class PricingStrategy
  def initialize(product, selected_options)
    @product = product
    @selected_options = selected_options
  end

  def calculate
    raise NotImplementedError, 'Subclasses must implement the calculate method'
  end
end
