#!/usr/bin/env ruby

# file: activity-logger.rb

require 'dynarex-daily'

class ActivityLogger
  
  def initialize(path=nil)
    Dir.chdir(path) if path    
  end

  def create(desc='')
    DynarexDaily.new.create(time: Time.now.to_s, desc: desc).save
  end
  
  # Returns true if the time from the last entry exceeds 45 minutes.
  #
  def expired?() 
    (Time.now - Time.parse(DynarexDaily.new.to_h.last[:time])) / 60 >= 45  
  end
end
