FactoryGirl.define do
  factory :project do
    sequence :name do |n|
      "name#{n}"
    end
    client
  end
end
