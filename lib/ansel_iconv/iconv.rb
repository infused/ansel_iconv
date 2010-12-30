# encoding: ascii-8bit

module ANSEL
  class Iconv    
    def initialize(to, from = 'ANSEL')
      @converter = (from == 'ANSEL') ? Convert.new(to) : ::Iconv.new(to, from)
    end
    
    def iconv(*args)
      @converter.iconv(*args)
    end
  end
end