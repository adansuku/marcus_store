class VariantProductBuilder < BaseProductBuilder
  def build(variants_data)
    @errors = [] # Refresh errors
    @selected_variant_options = [] # Optiosn to validate

    variants_data.each do |variant_data|
      variant = product.variants.build(
        sku: variant_data[:sku],
        price: variant_data[:price],
        stock_quantity: variant_data[:stock_quantity]
      )

      unless variant.valid?
        errors << "Variant is invalid: #{variant.errors.full_messages.join(', ')}"
        next
      end

      variant_data[:options].each do |option_data|
        option = variant.variant_options.build(
          option_name: option_data[:name],
          option_value: option_data[:value]
        )

        if option.valid?
          @selected_variant_options << option
        else
          errors << "Option is invalid: #{option.errors.full_messages.join(', ')}"
        end
      end
    end

    errors.empty?
  end
end
