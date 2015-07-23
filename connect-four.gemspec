Gem::Specification.new do |s|
  s.authors       = 'Blaine Schmeisser'
  s.name          = 'connect-four'
  s.email         = 'blainesch@gmail.com'
  s.homepage      = 'https://github.com/blainesch/connect-four'
  s.version       = '0.0.1'
  s.summary       = 'Command line connect four game.'
  s.description   = 'Play connect four over the command line with your friends.'
  s.licenses      = ['MIT']
  s.require_paths = ['lib', 'bin']
  s.files         = `git ls-files`.split("\n")
  s.has_rdoc      = false
  s.executables   <<  'connect-four'

  s.add_runtime_dependency 'colorize', '0.7.7'
end
