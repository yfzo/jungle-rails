class LineItem < ActiveRecord::Base

  belongs_to :order
  belongs_to :product
  # def product
  #   Product.find(self.product_id)
  # end

  monetize :item_price_cents, numericality: true
  monetize :total_price_cents, numericality: true

end
