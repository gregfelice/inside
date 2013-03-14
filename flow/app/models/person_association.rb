class PersonAssociation < ActiveRecord::Base

  attr_accessible :description, :sink_id, :source_id, :association_type, :source, :sink

  belongs_to :source,   :class_name => "Person"
  belongs_to :sink,     :class_name => "Person"

  validates_presence_of :association_type
  validates_uniqueness_of :sink_id, :scope => [:source_id, :association_type]

  validates :association_type, :inclusion => { :in => [:direct_reporting, :dotted_reporting], :message => "%{value} is not a valid person association type" }

end
