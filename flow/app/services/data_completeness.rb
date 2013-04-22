require 'singleton'

class DataCompleteness
  include Singleton

  #def load_rails_environment
  #  ENV["RAILS_ENV"] ||= "development"
  #  require File.dirname(__FILE__) + "/config/environment.rb"
  #  puts "Rails environment loaded."
  #end

  def get_data_completeness
    attrs = Person.accessible_attributes
    total = Person.count
    vals = {}
    attrs.each {|a|
      begin
        query = "#{a} is null or length( #{a} ) = 0"
        count = Person.where(query).count
        vals[a] = pct(total, count)
      rescue
      end
    }
    vals
  end

  private

  def pct(total, value)
    (100 - (value.to_f / total.to_f * 100)).round(2)
  end

end

