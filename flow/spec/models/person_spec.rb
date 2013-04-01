require 'spec_helper'
require 'yaml'

describe "Person Model" do

  # person
  # rails g scaffold Person name:string title:string type:string
  it "can be created", :focus => true do
    person = build(:person)
    # puts person.inspect
    person.save!
  end

  it "can show class variables", :focus => true do
    #Person.person_types.each {|x| # puts x.to_s.humanize }
    #Person.hr_statuses.each {|x| # puts x.to_s.humanize }
    #Person.hiring_statuses.each {|x| # puts x.to_s.humanize }
    #PersonAssociation.association_types.each {|x| puts x.to_s.humanize }
  end

  it "can have a direct supervisor", :focus => true do

    p = create(:person)
    op = create(:person, name: "direct super")

    # # puts Person.all.to_yaml

    p.add_direct_supervisor(op)

    p.save!

    assocs = p.source_associations
    # # puts "source assocs #{assocs.inspect}"
    assocs.size.should == 1
    assocs.first.source_id.should == op.id
    assocs.first.sink_id.should == p.id

    supers = p.direct_supervisors
    # # puts "supers #{supers.inspect}"
    supers.size.should == 1
    supers.first.id.should == op.id

    sinks = p.sinks
    sinks.size.should == 0
    # # puts "sinks #{sinks.inspect}"

    sources = p.sources
    # # puts "sources #{sources.inspect}"
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


  it "can have a dotted subordinate", :focus => true do
    p = create(:person)
    op = create(:person, name: "dotted sub")

    p.add_dotted_subordinate(op)
    p.save!

    assocs = p.sink_associations
    assocs.size.should                   == 1
    assocs.first.source_id.should        == p.id
    assocs.first.sink_id.should          == op.id
    assocs.first.association_type.should == 'dotted_reporting'

    assocs = p.sink_associations.where(:association_type => :dotted_reporting)
    assocs.size.should                   == 1
    assocs.first.source_id.should        == p.id
    assocs.first.sink_id.should          == op.id
    assocs.first.association_type.should == 'dotted_reporting'

    subs = p.sink_associations.where(:association_type => :dotted_reporting).map { |ds| ds.sink }
    subs.first.id.should                 == op.id

    sinks = p.sinks
    sinks.size.should                    == 1
    sinks.first.id.should                == op.id

    subs = p.dotted_subordinates
    subs.size.should                     == 1
    subs.first.id.should                 == op.id
  end


  it "can have a dotted supervisor", :focus => true do
    p = create(:person)
    op = create(:person, name: "dotted sub")

    p.add_dotted_supervisor(op)
    p.save!

    assocs = p.source_associations
    assocs.size.should                     == 1
    assocs.first.sink_id.should            == p.id
    assocs.first.source_id.should          == op.id
    assocs.first.association_type.should   == 'dotted_reporting'

    assocs = p.source_associations.where(:association_type => :dotted_reporting)
    assocs.size.should                     == 1
    assocs.first.sink_id.should            == p.id
    assocs.first.source_id.should          == op.id
    assocs.first.association_type.should   == 'dotted_reporting'

    subs = p.source_associations.where(:association_type => :dotted_reporting).map { |ds| ds.source }
    subs.first.id.should                   == op.id

    sources = p.sources
    sources.size.should                    == 1
    sources.first.id.should                == op.id

    subs = p.dotted_supervisors
    subs.size.should                       == 1
    subs.first.id.should                   == op.id
  end


  # group
  # rails g scaffold Group name:string description:text type:string

  # group assocation (group <-> group)
  # rails g scaffold GroupAssociation name:string  description:text type:string source_id:integer sink_id:integer

  # group membership (person <-> group)
  # rails g scaffold GroupMembership description:text type:string group_id:integer person_id:integer

end


