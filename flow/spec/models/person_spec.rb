require 'spec_helper'
require 'yaml'

describe "Person Model" do

  # person
  # rails g scaffold Person name:string title:string type:string
  it "can be created", :focus => true do
    person = create(:person)
    person.should_not be_nil
  end


  it "can retrieve assocations with people via getters", :focus => true do
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

    person.direct_supervisors.size.should == 1
    person.dotted_supervisors.size.should == 1
    person.direct_subordinates.size.should == 1
    person.dotted_subordinates.size.should == 1

  end


  it "can get assocation records for that person of a specific type", :focus => true do
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

    # source assocations is where you are the subordinate. i think.
    # person.source_assocations this is where you are pointing to someone as the source.
    supervisors = person.source_associations.where(:association_type => :direct_reporting)

  end


  it "can have a direct supervisor", :focus => true do

    p = create(:person)
    op = create(:person, name: "direct super")

    # puts Person.all.to_yaml

    p.add_direct_supervisor(op)

    p.save!

    assocs = p.source_associations
    # puts "source assocs #{assocs.inspect}"
    assocs.size.should == 1
    assocs.first.source_id.should == op.id
    assocs.first.sink_id.should == p.id

    supers = p.direct_supervisors
    # puts "supers #{supers.inspect}"
    supers.size.should == 1
    supers.first.id.should == op.id

    sinks = p.sinks
    sinks.size.should == 0
    # puts "sinks #{sinks.inspect}"

    sources = p.sources
    # puts "sources #{sources.inspect}"
    sources.size.should == 1
    sources.first.id.should == op.id

  end

  it "can have a direct subordinate", :focus => true do

    p = create(:person)
    op = create(:person, name: "direct sub")

    p.add_direct_subordinate(op)
    p.save!

    assocs = p.sink_associations
    assocs.size.should                   == 1
    assocs.first.source_id.should        == p.id
    assocs.first.sink_id.should          == op.id
    assocs.first.association_type.should == 'direct_reporting'

    assocs = p.sink_associations.where(:association_type => :direct_reporting)
    assocs.size.should                   == 1
    assocs.first.source_id.should        == p.id
    assocs.first.sink_id.should          == op.id
    assocs.first.association_type.should == 'direct_reporting'

    subs = p.sink_associations.where(:association_type => :direct_reporting).map { |ds| ds.sink }
    subs.first.id.should                 == op.id

    sinks = p.sinks
    sinks.size.should                    == 1
    sinks.first.id.should                == op.id

    subs = p.direct_subordinates
    subs.size.should                     == 1
    subs.first.id.should                 == op.id

  end

  it "can have a dotted supervisor", :focus => true



  it "can have a dotted subordinate", :focus => true


  # person association (person <-> person)
  # rails g scaffold PersonAssociation description:text person_type:string source_id:integer sink_id:integer
  it "can be associated with other people", :focus => false  do
    person = create(:person)

    direct_supervisor = create(:person, name: "direct super")
    dotted_supervisor = create(:person, name: "dotted super")

    direct_subordinate = create(:person, name: "direct sub")
    dotted_subordinate = create(:person, name: "dotted sub")

    person.add_direct_supervisor(direct_supervisor)
    person.add_dotted_supervisor(dotted_supervisor)

    person.add_direct_subordinate(direct_subordinate)
    person.add_dotted_subordinate(dotted_subordinate)

    person.save!

    person.sink_associations.size.should == 2
    person.source_associations.size.should == 2

    # puts person.sink_associations.to_yaml
    # puts Person.all.to_yaml
    # puts PersonAssociation.all.to_yaml

    person.direct_supervisors.size.should == 1
    person.dotted_supervisors.size.should == 1
    person.direct_subordinates.size.should == 1
    person.dotted_subordinates.size.should == 1

    person.direct_supervisors.first.name.should == direct_supervisor.name
    person.dotted_supervisors.first.name.should == dotted_supervisor.name
    person.direct_subordinates.first.name.should == direct_subordinate.name
    person.dotted_supervisors.first.name.should == dotted_subordinate.name

  end

  # group
  # rails g scaffold Group name:string description:text type:string

  # group assocation (group <-> group)
  # rails g scaffold GroupAssociation name:string  description:text type:string source_id:integer sink_id:integer

  # group membership (person <-> group)
  # rails g scaffold GroupMembership description:text type:string group_id:integer person_id:integer

end


