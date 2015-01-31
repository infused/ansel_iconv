# encoding: ascii-8bit

module ANSEL
  class Converter
    include ANSEL::CharacterMap

    def initialize(to_charset = 'UTF-8')
      @to_charset = to_charset
    end

    def ansi_to_utf16
      @ansi_to_utf16 ||= @@non_combining.merge(@@combining)
    end

    def convert(string)
      output = ''
      scanner = StringScanner.new(string)
      until scanner.eos? do
        byte = scanner.get_byte
        char = byte.unpack('C')[0]

        case char
        when 0x00..0x7F
          output << byte.force_encoding('UTF-8')
        when 0x88..0xC8
          hex_key = char.to_s(16).upcase
          output << (ansi_to_utf16[hex_key] || ansi_to_utf16['ERR']).force_encoding('UTF-16BE').encode('UTF-8')
          scanner.get_byte # ignore the next byte
        when 0xE0..0xFB
          [2, 1, 0].each do |n| # try 3 bytes, then 2 bytes, then 1 byte
            bytes = [char.to_s(16).upcase]
            scanner.peek(n).each_byte {|b| bytes << b.to_s(16).upcase}
            hex_key = bytes.join('+')
            if ansi_to_utf16.has_key?(hex_key)
              output << ansi_to_utf16[hex_key].force_encoding('UTF-16BE').encode('UTF-8')
              n.times {scanner.get_byte}
              break
            end
          end
        else
          output << ansi_to_utf16['ERR'].force_encoding('UTF-16BE').encode('UTF-8')
          scanner.get_byte if scanner.get_byte.unpack('C')[0] >= 0xE0 # ignore the next byte
        end
      end

      output.force_encoding('UTF-8')
    end

  end
end
