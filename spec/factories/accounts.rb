FactoryGirl.define do
  factory :account do
    sequence :name do |n|
      "name#{n}"
    end
  end
end