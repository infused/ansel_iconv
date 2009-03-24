Gem::Specification.new do |s|
  s.name = %q{ansel_iconv}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Keith Morrison"]
  s.date = %q{2009-03-23}
  s.description = %q{Convert ANSEL encoded text to any other encoding available to Iconv}
  s.email = %q{keithm@infused.org}
  s.files = ["History.txt", "Manifest.txt", "README.txt", "Rakefile", "lib/ansel_iconv.rb", "test/ansel_iconv_test.rb", "test/test_helper.rb"]
  s.has_rdoc = true
  s.homepage = ["http://github.com/infused/ansel-iconv/tree/master"]
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Convert ANSEL encoded text}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 2.1.0"])
    else
      s.add_dependency(%q<activesupport>, [">= 2.1.0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 2.1.0"])
  end
end
