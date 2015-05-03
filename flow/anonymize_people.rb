#!/usr/bin/env ruby

#
# replace people names with an entry from a list of fake names
#

require 'json'

class AnonymizePeople

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

    fakes = []
    l = ""
    File.open('anon.txt').each do |line|
      line.chomp!
      s = line.split
      puts s.inspect
      # puts line
      # puts "[#{line}]"
      fakes << "#{s[0]} #{s[1]}"
    end
    puts fakes.length

    people = Person.all
    people.each do |p|

      # puts fakes.pop
      # puts "#{p.name} ---> [#{fakes.pop}]"
      p.name = fakes.pop
      p.save!
      
    end
  end

end

########################################################
m = AnonymizePeople.new
m.run
########################################################



