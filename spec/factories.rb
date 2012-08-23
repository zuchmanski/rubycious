FactoryGirl.define do
  factory :user do
    uid { rand 2..1000 }
    username "john_doe"
    email "john@doe.com"
    admin false
  end

  factory :article do
    title "Marshmallow jujubes gummies dessert croissant halvah."
    body "Jelly fruitcake sweet roll croissant bear claw cotton candy danish icing. Sweet roll icing brownie oat cake."
    url "http://rubycious.com"
    user
    verified false
  end
end