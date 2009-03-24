PROJECT_ROOT = File.expand_path(File.dirname(__FILE__))
$: << File.join(PROJECT_ROOT, 'lib')

require 'rubygems'
require 'ansel_iconv'
require 'rake/testtask'
require 'trowel'

Trowel.define_tasks do |p|
  p.name = 'ansel_iconv'
  p.description = 'Convert ANSEL encoded text to any other encoding available to Iconv'
  p.summary = 'Convert ANSEL encoded text'
  p.version = '1.0.0'
  p.platform = Gem::Platform::RUBY
  p.authors = ['Keith Morrison']
  p.email = 'keithm@infused.org'
  p.add_dependency(%q<activesupport>, [">= 2.1.0"])
end

desc 'Default: run unit tests.'
task :default => :test

Rake::TestTask.new(:test) do |t|
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
  t.libs << 'test'
end