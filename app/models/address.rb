class Address
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture, :city, :address, :building, :phone_number

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 0 }
    validates :city
    validates :address
    validates :phone_number,format:{with: /\A\d{11}\z/ }
  end

  with_options foreign_key: true do,
    validates :order
  end

  def save
    Order.create(item_id: item.id, user_id: user.id)
    Address.create(
      postal_code: postal_code, 
      prefecture: prefecture, 
      city: city, 
      address: address, 
      building: building, 
      phone_number: phone_number
    )
  end
end


