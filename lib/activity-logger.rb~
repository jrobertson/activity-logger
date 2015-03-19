#!/usr/bin/env ruby

# file: activity-logger.rb

require 'dynarex-daily'
require 'simple-config'

class ActivityLogger

  attr_writer :xml_instruction
  
  def initialize(dir=nil, options={}, config: nil)
    
    @options = options
    @publish_html = false

    
    if config then
      
      h = SimpleConfig.new(config).to_h
      dir, @urlbase, @edit_url, @css_url, @xsl_path = \
                       %i(dir urlbase edit_url css_url, xsl_path).map{|x| h[x]}
      @publish_html = true
    end
    
    Dir.chdir(dir) if dir
  end

  def create(desc='', time=Time.now)

    ddaily = DynarexDaily.new(nil, @options)
    ddaily.default_key = 'uid' # adds an auto id
    ddaily.xml_instruction = @xml_instruction

    ddaily.create(time: time.to_s, desc: desc)
    ddaily.save
    
    if @publish_html then
      File.write 'index.txt', ddaily.to_s
      save_html() 
    end
    
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
  
  private

  def add(summary, name, s)
    summary.add Rexle::Element.new(name).add_text s
  end
  
  def render_html(doc)
    
    #lib = File.exists?('notices.xsl') ? '.' : File.dirname(__FILE__)
    #xslt_buffer = File.read(File.join(lib,'notices.xsl'))
    xslt_buffer = File.read @xsl_path

    xslt  = Nokogiri::XSLT(xslt_buffer)
    out = xslt.transform(Nokogiri::XML(doc.xml))
    File.write 'index.html', out    
  end
  
  def save_html()
    
    newfile = 'formatted.xml'
    FileUtils.cp 'dynarexdaily.xml', newfile
    doc = Rexle.new File.read(newfile)
    
    summary = doc.root.element('summary')

    add summary, 'edit_url', "%s/index.txt" % [@edit_url]
    add summary, 'date',      Date.today.strftime("%d-%b-%Y").upcase
    add summary, 'css_url',   @css_url
    add summary, 'published', Time.now.strftime("%d-%m-%Y %H:%M")    
    
    doc.root.xpath('records/entry') do |entry|
      
      e = entry.element('time')
      e.text = Time.parse(e.text).strftime("%-l:%M%P")
    end
    
    File.write newfile, doc.xml(pretty: true)    
    render_html doc
  end

end
