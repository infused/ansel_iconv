# encoding: ascii-8bit

module ANSEL
  class Iconv
    def initialize(to, from = 'ANSEL')
      @converter = Convert.new(to)
    end

    def convert(*args)
      @converter.convert(*args)
    end
  end
end
