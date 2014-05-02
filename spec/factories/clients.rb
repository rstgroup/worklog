FactoryGirl.define do
  factory :client do
    sequence :name do |n|
      "name#{n}"
    end
  end
end
