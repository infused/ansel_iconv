# encoding: ascii-8bit

module ANSEL
  class Iconv
    def initialize(to, from = 'ANSEL')
      @converter = Convert.new(to)
    end

    def iconv(*args)
      @converter.iconv(*args)
    end
  end
end
