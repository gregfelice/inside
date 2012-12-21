class Part < ActiveRecord::Base
  belongs_to :widget
  attr_accessible :commenter, :description, :widget_id
end
