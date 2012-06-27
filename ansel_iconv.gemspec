# encoding: ascii-8bit

lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
require 'ansel_iconv/version'

Gem::Specification.new do |s|
  s.name = 'ansel_iconv'
  s.version = ANSEL::Iconv::VERSION
  s.authors = ["Keith Morrison"]
  s.email = 'keithm@infused.org'
  s.homepage = 'http://github.com/infused/ansel_iconv'
  s.summary = 'Convert ANSEL encoded text'
  s.description = 'Convert ANSEL encoded text to any other encoding available to Iconv'

  s.rdoc_options = ['--charset=UTF-8']
  s.extra_rdoc_files = ['README.md', 'CHANGELOG.md', 'MIT-LICENSE']
  s.files = Dir['[A-Z]*', '{lib,test}/**/*', 'ansel_iconv.gemspec']
  s.test_files = Dir.glob('test/**/*_test.rb')
  s.require_paths = ['lib']
  
  s.required_rubygems_version = '>= 1.3.6'
  s.add_development_dependency 'rspec', '~> 2.10.0'
  s.add_development_dependency 'rake', '~> 0.9.2'
end

