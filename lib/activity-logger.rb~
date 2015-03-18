#!/usr/bin/env ruby

# file: activity-logger.rb

require 'dynarex-daily'

class ActivityLogger

  attr_writer :xml_instruction
  
  def initialize(path=nil, options={})
    @options = options
    Dir.chdir(path) if path    
  end

  def create(desc='', time=Time.now)

    ddaily = DynarexDaily.new(nil, @options)
    ddaily.default_key = 'uid' # adds an auto id
    ddaily.xml_instruction = @xml_instruction

    ddaily.create(time: time.to_s, desc: desc)
    ddaily.save

  end
  
  # Returns true if the time from the last entry exceeds 45 minutes.
  #
  def expired?()
    records = DynarexDaily.new.to_h
    if records and !records.empty? then
      (Time.now - Time.parse(records.last[:time])) / 60 >= 45  
    else
      true
    end
  end

end