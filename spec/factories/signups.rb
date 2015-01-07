FactoryGirl.define do
  factory :signup do
    sequence :email do |n|
      "email#{n}@mail.pl"
    end
    company_name "company"
    password "foobar"
  end
end