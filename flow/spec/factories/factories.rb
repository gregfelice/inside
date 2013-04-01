require 'factory_girl'

FactoryGirl.define do

  factory :employee do
    sequence(:full_name) {|n| "Joe #{n}" }
    # full_name "employee"
    job_title "president"
  end

  factory :person do
    sequence(:name) {|n| "Joe #{n}" }
    title "worker"
    person_type 'employee'
    temporary false
    hr_status 'active'
    part_time false
    hiring_status 'filled'
  end

  factory :portfolio do
    sequence(:name) {|n| "Portfolio #{n}" }
    description "this is a portfolio"
  end

  factory :plan do
    sequence(:name) {|n| "Plan #{n}" }
    description "this is a plan"
    portfolio_category "mobile"
  end

  factory :milestone do
    sequence(:name) {|n| "Milestone #{n}" }
    business_driver "user experience"
    description "this is a milestone."
    health "green"
    planned_start Date.today
    planned_finish Date.today.next_month
    status "started"
  end


end
