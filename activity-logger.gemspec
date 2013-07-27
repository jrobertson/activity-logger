Gem::Specification.new do |s|
  s.name = 'activity-logger'
  s.version = '0.1.10'
  s.summary = 'activity-logger'
  s.authors = ['James Robertson']
  s.files = Dir['lib/**/*.rb']
  s.add_dependency('dynarex-daily')
 
  s.signing_key = '../privatekeys/activity-logger.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/activity-logger'
end
