#  id        :integer          not null, primary key
#  part_id   :integer
#  user_id   :integer
#  name      :text
#  duration  :integer
#  worked_on :date


FactoryGirl.define do
  factory :timelog do
    full_part_name "some"
    name "some name"
    duration 1
    worked_on Date.today
    after(:build) do |user|
      client = FactoryGirl.create :client
      project = FactoryGirl.create :project, :client => client
      part = FactoryGirl.create :part, :project => project, :name => "some"
      user.part_id = part.id
    end
  end
end
