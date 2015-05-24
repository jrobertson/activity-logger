#!/usr/bin/env ruby

# file: activity-logger.rb

require 'dynarex-daily'
require 'simple-config'


module Library

  def fetch_file(filename)

    lib = File.dirname(__FILE__)
    File.read File.join(lib,'..','stylesheet',filename)

  end
end

class ActivityLogger

  
  def initialize(dir: nil, options: {}, config: nil)

    @options = options
    @publish_html = false

    
    if config then
      
      h = SimpleConfig.new(config).to_h
      dir, @urlbase, @edit_url, @css_url, @xsl_path = \
                       %i(dir urlbase edit_url css_url xsl_path).map{|x| h[x]}
      @publish_html = true
    end
    
    Dir.chdir(dir) if dir
  end

  def create(desc='', time=Time.now)

    ddaily = DynarexDaily.new(nil, options: @options)
    
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
    
    xslt_buffer = if @xsl_path then
    
      buffer, _ = RXFHelper.read @xsl_path
      buffer
      
    else
      
      fetch_file('notices.xsl')
      
    end

    xslt  = Nokogiri::XSLT(xslt_buffer)
    out = xslt.transform(Nokogiri::XML(doc.xml))    
    File.write 'index.html', out    
  end
  
  def save_html()
    
    newfile = 'formatted.xml'
    FileUtils.cp 'dynarexdaily.xml', newfile
    doc = Rexle.new File.read(newfile)
    
    summary = doc.root.element('summary')

    date = Date.today.strftime("%d-%b-%Y").upcase
    add summary, 'title',     date + ' Notices'
    add summary, 'edit_url',  @edit_url
    summary.element('date').text = date
    add summary, 'css_url',   @css_url
    add summary, 'published', Time.now.strftime("%d-%m-%Y %H:%M")    
    
    doc.root.xpath('records/entry') do |entry|
      
      e = entry.element('time')
      e.text = Time.parse(e.text).strftime("%-l:%M%P")
      desc = entry.element('desc')
      desc.add  Rexle.new("<span>%s</span>" % desc.text.unescape).root
      desc.text = ''      
    end
    
    File.write newfile, doc.xml(pretty: true)    
    render_html doc
    
    # save the related CSS file locally if the file doesn't already exist

    if not File.exists? 'notices.css' then
      File.write 'notices.css', fetch_file('notices.css')
    end    
  end

end