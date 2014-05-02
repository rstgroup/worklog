FactoryGirl.define do
  factory :part do
    sequence :name do |n|
      "name#{n}"
    end
    project
  end
end
