FactoryBot.define do
  factory :user_order do
    postal_code   { '123-4567' }
    prefecture_id { 1 }
    city          { '渋谷区' }
    address       { '神南1-18-2' }
    building      { '' }
    phone_number  { '12345678901' }
    user_id       { 1 }
    item_id       { 1 }
    token         { 'tok_abcdefghijk00000000000000000' }
  end
end
