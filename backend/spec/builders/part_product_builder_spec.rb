require 'rails_helper'

RSpec.describe PartProductBuilder do
  let(:product) { create(:no_parts_product) }
  let(:builder) { PartProductBuilder.new(product) }

  let(:finish) { create(:part) }
  let(:frame) { create(:part) }

  before do
    # Asociamos las partes con el producto
    create(:product_part, product: product, part: frame, required: true)
    create(:product_part, product: product, part: finish, required: true)
  end

  context 'when price rules apply' do
    it 'calculates the correct price' do
      # Crear opciones
      matte_finish = create(:part_option, part: finish, name: 'Matte Finish', price: 50)
      full_suspension = create(:part_option, part: frame, name: 'Full-Suspension', price: 150)

      # Crear regla de precio
      create(:pricing_rule, part_option: matte_finish, dependent_part_option: full_suspension, price: 50)

      # Construir producto
      builder.build([
        { name: frame.name, required: true, options: [{ name: full_suspension.name }] },
        { name: finish.name, required: true, options: [{ name: matte_finish.name }] }
      ])

      # Validar y calcular el precio
      expect(builder.validate).to be true
      expect(builder.total_price.to_f).to eq(250) # 500 (base) + 150 (Full-Suspension) + 50 (Matte Finish) + 50 (rule)
    end
  end

  context 'when restrictions are violated' do
    it 'returns errors' do
      # Crear restricciones
      mountain_wheels = create(:part_option, part: finish,  name: 'Mountain Wheels')
      diamond_frame = create(:part_option, part:frame, name: 'Diamond Frame')

      create(:restriction, source_part_option: mountain_wheels, target_part_option: diamond_frame, restriction_type: 'excludes')

      # Intentar construir producto con opciones inválidas
      builder.build([
        { name: frame.name, required: true, options: [{ name: 'Diamond Frame', price: 100 }] },
        { name: finish.name, required: true, options: [{ name: 'Mountain Wheels', price: 80 }] }
      ])

      expect(builder.validate).to be false
      expect(builder.errors).to include('Option Mountain Wheels cannot be combined with Diamond Frame')
    end
  end

  context 'when no restrictions or price rules exist' do
    it 'builds a product successfully' do
      matte_finish = create(:part_option, part: finish, name: 'Matte Finish', price: 110)
      full_suspension = create(:part_option, part: frame, name: 'Full-Suspension', price: 130)

      # Construir producto
      builder.build([
        { name: frame.name, required: true, options: [{ name: 'Full-Suspension' }] },
        { name: finish.name, required: true, options: [{ name: 'Matte Finish' }] }
      ])

      # Validar y calcular el precio
      expect(builder.validate).to be true
      expect(builder.total_price.to_f).to eq(240) # 500 (base) + 150 (Full-Suspension) + 50 (Matte Finish) + 50 (rule)

    end
  end
end
