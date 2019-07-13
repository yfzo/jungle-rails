class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  validates :product, presence: true
  validates :user, presence: true
  validates :description, presence: true, length: { maximum: 300 }
  validates :rating, presence: true, numericality: { greater_than: 0, less_than: 6 }
end
