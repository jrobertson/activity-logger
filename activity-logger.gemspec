Gem::Specification.new do |s|
  s.name = 'activity-logger'
  s.version = '0.5.0'
  s.summary = 'Uses the Dynarex-daily gem to log notices for the day'
  s.authors = ['James Robertson']
  s.files = Dir['lib/activity-logger.rb', 'stylesheet/notices.xsl', 'stylesheet/notices.css']
  s.add_runtime_dependency('dynarex-daily', '~> 0.5', '>=0.5.1')
  s.add_runtime_dependency('simple-config', '~> 0.7', '>=0.7.2')
  s.add_runtime_dependency('rxfileio', '~> 0.2', '>=0.2.1')
  s.signing_key = '../privatekeys/activity-logger.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'digital.robertson@gmail.com'
  s.homepage = 'https://github.com/jrobertson/activity-logger'
  s.required_ruby_version = '>= 2.1.2'
end
