# encoding: ascii-8bit

module ANSEL
  class Iconv
    delegate :iconv, :to => :@converter
    
    def initialize(to, from = 'ANSEL')
      @converter = (from == 'ANSEL') ? Convert.new(to) : ::Iconv.new(to, from)
    end
  end
end