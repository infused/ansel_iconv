# encoding: ascii-8bit

$:.unshift(File.dirname(__FILE__) + '/../lib/')
require 'rubygems'
require 'rspec'
require 'ansel_iconv'

# if RUBY_VERSION < '1.9'
#   class String
#     def force_encoding(e)
#       self
#     end
#   end
# end

RSpec.configure do |config|

end
