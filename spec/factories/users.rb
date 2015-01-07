# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "email#{n}@domain.pl"
    end
    name "Wojciech Krysiak"
    password "dupadupa8"
  end
end