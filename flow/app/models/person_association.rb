class PersonAssociation < ActiveRecord::Base

  attr_accessible :description, :sink_id, :source_id, :association_type, :source, :sink

  belongs_to :source,   :class_name => "Person"
  belongs_to :sink,     :class_name => "Person"

  validates_presence_of :association_type
  validates_uniqueness_of :sink_id, :scope => [:source_id, :association_type]

  # validates assocation type in ... blah blah
end
