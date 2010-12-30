# encoding: utf-8

require 'rubygems'
require 'rake/testtask'

# require 'rspec/core/rake_task'
# RSpec::Core::RakeTask.new :spec do |t|
#   t.rspec_opts = %w(-fs --color)
# end
# 
# task :default => :spec

desc 'Default: run unit tests.'
task :default => :test

Rake::TestTask.new(:test) do |t|
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
  t.libs << 'test'
end

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I lib -r dbf.rb"
end
