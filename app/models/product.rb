class Product < ApplicationRecord
  paginates_per 6
  belongs_to :department
  has_and_belongs_to_many :promotions
end
