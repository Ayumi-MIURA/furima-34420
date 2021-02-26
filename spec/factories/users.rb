FactoryBot.define do
  factory :user do
    nickname              { 'test' }
    email                 { Faker::Internet.free_email }
    password              { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    last_name             { '真子' }
    first_name            { '就有' }
    last_name_kana        { 'マコ' }
    first_name_kana       { 'ユキナリ' }
    birthday              { '2021/01/18' }
  end
end
