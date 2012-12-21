#!/bin/env ruby 

require 'json'

=begin

import for json dump. run as a script (see bottom of file for invocation).

todo: unit tests

=end
class Jimport

  @all # hash containing all rows from JSON files
  
  def initialize(filenames)

    load_rails_environment
    
    @all = []
    filenames.each {|fn|
      file = File.read(fn)
      objects = JSON.parse(file)
      objects.each {|o| @all << o}
    }
    puts "All loaded. Count: #{@all.count}"

  end
  
  def run
    import_employees(get_employees_from_file)
    import_reporting_relationships(get_reporting_relationships_from_file)
  end

  private
  
  def load_rails_environment
    ENV["RAILS_ENV"] ||= "development"
    require File.dirname(__FILE__) + "/config/environment.rb"
    puts "Rails environment loaded."
  end
  
  def rails_environment_smoke_test
    w = Widget.new
    w.name = "Greg Felice"
    w.title = "Glorious Widget #" + `date +%N`.chomp
    w.content = "This widget was created on " + `date`.chomp
    w.save
  end
  
  def get_employees_from_file

    employees = []

    @all.each {|o| 
      
      if o['model'] == 'orgchartapp.employee'
        
        oh = {}
        oh['contractor']       = o['fields']['contractor']
        oh['part_time_status'] = o['fields']['part_time_status']
        oh['full_name']        = o['fields']['full_name']
        oh['job_title']        = o['fields']['job_title']    
        
        employees << oh
      end
    }
    employees
    
  end
  
  def import_employees(employees)
    
    employees.each {|e|
      
      employeeToSave = Employee.new do |ets|
        ets.contractor              = e['contractor']
        ets.part_time_status        = e['part_time_status']
        ets.full_name               = e['full_name']
        ets.job_title               = e['job_title']
      end
      
      employeeToSave.save
    }
    
  end
  
  # {"pk": 2, "model": "orgchartapp.reportingrelationship", "fields": {"employee": 3, "supervisor": 1, "dotted": false}}
  def get_reporting_relationships_from_file

    reporting_relationships = []
    @all.each {|o| 
      
      if o['model'] == 'orgchartapp.reportingrelationship'
        
        rrh = {}
        rrh['employee_id']      = o['fields']['employee']
        rrh['supervisor_id']    = o['fields']['supervisor']
        rrh['dotted']           = o['fields']['dotted']
        
        reporting_relationships << rrh
      end
    }
    reporting_relationships
    
  end
  
  def find_employee_in_json_by_id(id)
    
    employees = @all.select {|r| r['model'] == 'orgchartapp.employee' && r['pk'] == id}
    
    employee = employees.first
  end
  
  def import_reporting_relationships(reporting_relationships)
    
    reporting_relationships.each {|rr|

      begin
      
        # fine the employee in the relationship
        employee_from_json = find_employee_in_json_by_id(rr['employee_id'])
        employee = Employee.find_by_full_name_and_job_title(
                                                            employee_from_json['fields']['full_name'], 
                                                            employee_from_json['fields']['job_title']
                                                            )
        
        # find the supervisor in the relationship
        supervisor_from_json = find_employee_in_json_by_id(rr['supervisor_id'])
        supervisor = Employee.find_by_full_name_and_job_title(
                                                              supervisor_from_json['fields']['full_name'], 
                                                              supervisor_from_json['fields']['job_title']
                                                              )
        
        # puts "#{supervisor.full_name} <- reports to -- #{employee.full_name}"

        # create a new reporting relationship
        rrtbs = ReportingRelationship.new
        rrtbs.employee   = employee
        rrtbs.supervisor = supervisor
        rrtbs.dotted     = rr['dotted']
        
        puts rrtbs.inspect

        employee.reporting_relationships << rrtbs
        employee.save
        
      rescue
        #puts "ERROR"
        puts $!
        #puts rr.inspect
        #puts "END ERROR"
      end

    }

  end
end


########################################################
filenames = ['employeeware_db.2012061101.json', 'employeeware_db.2012061102.json']

j = Jimport.new (filenames)
j.run
########################################################



