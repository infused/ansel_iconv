PROJECT_ROOT = File.expand_path(File.dirname(__FILE__))
$: << File.join(PROJECT_ROOT, 'lib')

require 'rubygems'
require 'trowel'
require 'ansel_iconv'
require 'rake/testtask'

Trowel.define_tasks do |p|
  p.name = 'ansel_iconv'
  p.version = '1.0.0'
  p.platform = Gem::Platform::RUBY
  p.authors = ['Keith Morrison']
  p.email = 'keithm@infused.org'
end

desc 'Default: run unit tests.'
task :default => :test

Rake::TestTask.new(:test) do |t|
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
  t.libs << 'test'
end