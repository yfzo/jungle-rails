require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'validates presence' do
      @category = Category.new name: 'Food'
      @product = @category.products.new({name: 'Cheese', price: 5, quantity: 3})
      expect(@product).to be_valid
    end
    it 'validates presence of name' do
      @category = Category.new name: 'Food'
      @product = @category.products.new({name: '', price: 5, quantity: 3})
      @product.valid?
      @product.errors.should have_key(:name)
    end
    it 'validates presence of price' do
      @category = Category.new name: 'Food'
      @product = @category.products.new({name: 'Cheese', quantity: 3})
      @product.valid?
      @product.errors.should have_key(:price)
    end
    it 'validates presence of quantity' do
      @category = Category.new name: 'Food'
      @product = @category.products.new({name: 'Cheese', price: 5})
      @product.valid?
      @product.errors.should have_key(:quantity)
    end
    it 'validates presence of category' do
      @category = Category.new name: 'Food'
      @product = Product.new({name: 'Cheese', price: 5, quantity: 3})
      @product.valid?
      @product.errors.should have_key(:category)
    end
  end
end
