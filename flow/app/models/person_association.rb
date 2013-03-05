class PersonAssociation < ActiveRecord::Base

  attr_accessible :description, :sink_id, :source_id, :person_type, :source, :sink

  belongs_to :source,   :class_name => "Person"
  belongs_to :sink,     :class_name => "Person"

  validates_presence_of :person_type
  validates_uniqueness_of :sink_id, :scope => [:source_id, :person_type]

  def self.types(symbol)
    types = {:direct_reporting => 'direct_reporting', :dotted_reporting => 'dotted reporting'}
    types[symbol]
  end

end
