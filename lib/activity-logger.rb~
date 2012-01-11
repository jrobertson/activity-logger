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
end
