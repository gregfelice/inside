require 'spec_helper'

describe "Plan Model" do

  it "can save milestones, and be saved within a portfolio", :focus => false do
    portfolio = create(:portfolio)
    plan = create(:plan)
    milestone = create(:milestone)
    plan.milestones << milestone
    portfolio.plans << plan
    portfolio.save!
    portfolio.plans.size.should == 1
    portfolio.plans.first.milestones.size.should == 1
  end

  it "can have resources allocated to it", :focus => false do
    plan = create(:plan)
    person = create(:person)

    plan.add_resource_allocation(person, 0.5, "infrastructure support")

    plan.resource_allocations.size.should == 1
    puts plan.resource_allocations.first.person.should_not be_nil
  end

end
