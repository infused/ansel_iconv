# encoding: ascii-8bit

module ANSEL
  class Convert
    include ANSEL::CharacterMap
    
    def initialize(to_charset = 'UTF-8')
      @to_charset = to_charset
      @ansi_to_utf8 = {}
      @ansi_to_utf8.merge!(@@non_combining)
      @ansi_to_utf8.merge!(@@combining)
    end

    def iconv(string)
      output = ''
      scanner = StringScanner.new(string)
      until scanner.eos? do
        byte = scanner.get_byte
        char = byte.unpack('C')[0]
    
        if char <= 0x7F
          output << byte
        elsif char >= 0x88 && char <= 0xC8
          hex_key = char.to_s(16).upcase
          output << ::Iconv.conv(@to_charset, 'UTF-16', @ansi_to_utf8.has_key?(hex_key) ? @ansi_to_utf8[hex_key] : @ansi_to_utf8['ERR'])
          scanner.get_byte # ignore the next byte
        elsif char >= 0xE0 && char <= 0xFB
          [2, 1, 0].each do |n| # try 3 bytes, then 2 bytes, then 1 byte
            bytes = [char.to_s(16).upcase]
            scanner.peek(n).each_byte {|b| bytes << b.to_s(16).upcase}
            hex_key = bytes.join("+")
            if @ansi_to_utf8.has_key?(hex_key)  
              output << ::Iconv.conv(@to_charset, 'UTF-16', @ansi_to_utf8[hex_key])
              n.times {scanner.get_byte}
              break
            end
          end
        else
          output << ::Iconv.conv(@to_charset, 'UTF-16', @ansi_to_utf8['ERR'])
          scanner.get_byte if scanner.get_byte.unpack('C')[0] >= 0xE0 # ignore the next byte
        end
      end
  
      @to_charset == 'UTF-8' ? output : ::Iconv.conv(@to_charset, 'UTF-8', output)
    end
  
  end
end