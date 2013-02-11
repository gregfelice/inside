require 'factory_girl'

FactoryGirl.define do

  factory :employee do
    sequence(:full_name) {|n| "Joe #{n}" }
    #full_name "employee"
    job_title "president"
  end
end
