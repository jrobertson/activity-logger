#!/usr/bin/env ruby

# file: activity-logger.rb

require 'dynarex-daily'

class ActivityLogger
  
  def initialize(path=nil, options={})
    Dir.chdir(path) if path    
  end

  def create(desc='', time=Time.now)
    sleep 0.8
    DynarexDaily.new(nil,options).create(time: time.to_s, desc: desc).save
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