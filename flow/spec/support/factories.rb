require 'factory_girl'

FactoryGirl.define do

  factory :employee do
    full_name "test employee"
    job_title "president"
  end

end
