Gem::Specification.new do |s|
  s.name = 'activity-logger'
  s.version = '0.1.8'
  s.summary = 'activity-logger'
  s.authors = ['James Robertson']
  s.files = Dir['lib/**/*.rb']
  s.add_dependency('dynarex-daily')
 
  s.signing_key = '../privatekeys/activity-logger.pem'
  s.cert_chain  = ['gem-public_cert.pem']
end
