require 'spec_helper'

describe "Person Model" do

  # person
  # rails g scaffold Person name:string title:string type:string
  it "can be created", :focus => true do
    person = create(:person)
    person.should_not be_nil
  end

  # person association (person <-> person)
  # rails g scaffold PersonAssociation description:text person_type:string source_id:integer sink_id:integer
  it "can be associated with other people", :focus => true do
    person = create(:person)

    direct_subordinate = create(:person)
    dotted_subordinate = create(:person)

    direct_supervisor = create(:person)
    dotted_supervisor = create(:person)

    person.add_direct_subordinate(direct_subordinate)
    person.add_dotted_subordinate(dotted_subordinate)

    person.add_direct_supervisor(direct_supervisor)
    person.add_dotted_supervisor(dotted_supervisor)

    person.save!

    person.sink_associations.size.should == 2
    person.source_associations.size.should == 2

    person.direct_supervisors.size.should == 1
    person.dotted_supervisors.size.should == 1
    person.direct_subordinates.size.should == 1
    person.dotted_subordinates.size.should == 1

  end

  # group
  # rails g scaffold Group name:string description:text type:string

  # group assocation (group <-> group)
  # rails g scaffold GroupAssociation name:string  description:text type:string source_id:integer sink_id:integer

  # group membership (person <-> group)
  # rails g scaffold GroupMembership description:text type:string group_id:integer person_id:integer

end


