#!/usr/bin/env ruby

# file: activity-logger.rb

require 'dynarex-daily'
require 'simple-config'
require 'rxfileio'


module Library

  def fetch_file(filename)

    lib = File.dirname(__FILE__)
    File.read File.join(lib,'..','stylesheet',filename)

  end
end

class ActivityLogger
  include RXFileIOModule
  include Library

  def initialize(dirpath=nil, dir: dirpath, xsl_path: nil, config: nil)

    @publish_html = false

    if config then

      h = SimpleConfig.new(config).to_h
      dir, @urlbase, @edit_url, @css_url, xsl = \
                       %i(dir urlbase edit_url css_url xsl_path).map{|x| h[x]}
      @xsl_path = xsl_path || xsl
      @publish_html = true

    end

    Dir.chdir(dir) if dir
  end

  def create(desc='', time=Time.now, id: id=nil)

    ddaily = DynarexDaily.new(nil, xslt: @xsl_path)

    ddaily.create(time: time.to_s, desc: desc, id: id)
    ddaily.save

    if @publish_html then

      File.write 'index.txt', ddaily.to_s
      save_html()
    end

  end



  private

  def add(summary, name, s)
    summary.add Rexle::Element.new(name).add_text s
  end

  def render_html(doc)

    xslt_buffer = if @xsl_path then

      buffer, _ = RXFReader.read @xsl_path
      buffer

    else

      puts 'activity-logger: warning: .xsl file not found, using notices.xsl'
      fetch_file('notices.xsl')

    end

    # jr280416 xslt  = Nokogiri::XSLT(xslt_buffer)
    # jr280416 out = xslt.transform(Nokogiri::XML(doc.xml))

    out = Rexslt.new(xslt_buffer, doc.xml).to_s

    FileX.write 'index.html', out
  end

  def save_html()

    newfile = 'formatted.xml'
    FileX.cp 'dynarexdaily.xml', newfile
    doc = Rexle.new FileX.read(newfile)

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

    FileX.write newfile, doc.xml(pretty: true)
    render_html doc

    # save the related CSS file locally if the file doesn't already exist

    css_file = File.basename @css_url

    if not FileX.exists? css_file then
      FileX.write css_file, fetch_file('notices.css')
    end

  end

end
