Gem::Specification.new do |s|
  s.name = 'activity-logger'
  s.version = '0.3.5'
  s.summary = 'Uses the Dynarex-daily gem to log notices for the day'
  s.authors = ['James Robertson']
  s.files = Dir['lib/activity-logger.rb', 'stylesheet/notices.xsl', 'stylesheet/notices.css']
  s.add_runtime_dependency('dynarex-daily', '~> 0.1', '>=0.1.14')
  s.add_runtime_dependency('simple-config', '~> 0.3', '>=0.3.0') 
  s.signing_key = '../privatekeys/activity-logger.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/activity-logger'
  s.required_ruby_version = '>= 2.1.2'
end
