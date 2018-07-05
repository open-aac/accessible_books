Gem::Specification.new do |s|
  s.name        = 'accessible_books'

  s.add_dependency 'typhoeus'
  s.add_dependency 'json'
  s.add_dependency 'nokogiri'
  s.add_development_dependency 'rails'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'ruby-debug'

  s.version     = '0.1.0'
  s.date        = '2018-07-05'
  s.summary     = "AccessibleBooks"
  s.extra_rdoc_files = %W(LICENSE)
  s.homepage = %q{http://github.com/CoughDrop/boy_band}
  s.description = "Utility for programmatic access to TarheelReader and other accessible books"
  s.authors     = ["Brian Whitmer"]
  s.email       = 'brian.whitmer@gmail.com'

	s.files = Dir["{lib}/**/*"] + ["LICENSE", "README.md"]
  s.require_paths = %W(lib)

  s.license     = 'MIT'
end