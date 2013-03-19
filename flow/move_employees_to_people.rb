#!/usr/bin/env ruby

require 'json'

class MoveEmployeesToPeople

  def initialize
    puts "loading environment..."
    load_rails_environment
    puts "environment loaded."
  end

  def load_rails_environment
    ENV["RAILS_ENV"] ||= "development"
    require File.dirname(__FILE__) + "/config/environment.rb"
    puts "Rails environment loaded."
  end

  def run
    employees = Employee.all

    employees.each do |e|

      p = Person.new
      p.name                = e.full_name
      p.title               = e.job_title
      p.person_type         = e.contractor == true ? 'contractor' : 'employee'
      p.temporary           = false
      p.hr_status           = 'active'
      p.part_time           = e.part_time_status == true ? true : false
      p.band                = ''
      p.cost_center         = ''
      p.business_unit       = ''
      p.hiring_status       = 'filled'

      puts p.inspect
      p.save!

    end

    people = Person.all
    people.each do |p|

      e = Employee.find_by_full_name(p.name)
      puts "working on #{e.full_name}"

      e.direct_supervisors.each {|o|
        puts "finding by name: #{o.full_name}"
        op = Person.find_by_name(o.full_name)
        puts "found: #{op.inspect}"

        p.add_direct_supervisor(op)

        p.save!
      }

    end
  end

end

########################################################
m = MoveEmployeesToPeople.new
m.run
########################################################



