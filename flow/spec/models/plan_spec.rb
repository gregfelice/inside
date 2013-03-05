require 'spec_helper'

describe "Plan Model" do

  it "can save milestones, and be saved within a portfolio", :focus => true do
    portfolio = create(:portfolio)
    plan = create(:plan)
    milestone = create(:milestone)
    plan.milestones << milestone
    portfolio.plans << plan
    portfolio.save!
    portfolio.plans.size.should == 1
    portfolio.plans.first.milestones.size.should == 1
  end

  it "can have resources allocated to it", :focus => true do
    milestone = create(:milestone)
    person = create(:person)
    milestone.add_resource_allocation(person, 0.5, "infrastructure support")
    milestone.resource_allocations.size.should == 1
    puts milestone.resource_allocations.first.person.should_not be_nil
  end

end
