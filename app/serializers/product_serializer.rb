class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :promotion
  def promotion
    active_promotion = self.object.promotions.find_by_active(true)
    dict = {code: active_promotion.code,
        price: calculate_discounted_price(self.object.price, active_promotion.discount)} if active_promotion
  end

  def calculate_discounted_price(original_price, percentage)
    original_price - (original_price * (percentage / 100.0))
  end
end
