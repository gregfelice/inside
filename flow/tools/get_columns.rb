#!/usr/bin/env ruby

require 'mysql2'

class GetColumns

  def load_rails_environment
    ENV["RAILS_ENV"] ||= "development"
    require File.dirname(__FILE__) + "/../config/environment.rb"
    puts "Rails environment loaded."
  end

  def connect_to_db
    ActiveRecord::Base.establish_connection(
      :adapter  => "mysql2",
      :host     => "localhost",
      :username => ARGV[0],
      :password => ARGV[1],
      :database => ARGV[2]
      )
  end

  def run

    puts "working with #{ARGV[0]}/#{ARGV[1]}@#{ARGV[2]}"
    load_rails_environment
    connect_to_db

    tables = [User, Person, PersonAssociation, Activity, Role]

    File.open('./db.sql', 'w') do |out|
      out.puts "columns for #{ARGV[2]}"
      out.puts ""
      tables.each {|t|
        out.puts "=========== #{t.name} =========="
        out.puts t.column_names.join(", ")
        out.puts ""
      }
    end

  end

end

p = GetColumns.new
p.run
