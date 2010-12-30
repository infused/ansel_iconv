# encoding: ascii-8bit

require 'spec_helper'

describe ANSEL::Iconv do
  before do
    @ansel = ANSEL::Iconv.new 'UTF-8'
  end
  
  describe '#iconv' do
  
    it "does not convert ASCII characters" do
      @ansel.iconv("\x20").should == ' '
      @ansel.iconv("\x78").should == 'x'
    end
  
    it 'converts invalid characters to the unicode replacement character' do
      @ansel.iconv("\xBE\x00").should == "�".force_encoding('utf-8')
      @ansel.iconv("\xD1\x00").should == "�".force_encoding('utf-8')
    end
  
    it 'converts valid ANSEL characters to UTF-8 equivalents' do
      # ANSEL non-combining mappings
      @ansel.iconv("\x88\x00").should == ''
      @ansel.iconv("\x89\x00").should == ''
      @ansel.iconv("\x8D\x00").should == ''
      @ansel.iconv("\x8E\x00").should == ''
      @ansel.iconv("\xA1\x00").should == "Ł".force_encoding('utf-8')
      @ansel.iconv("\xA2\x00").should == "Ø".force_encoding('utf-8')
      @ansel.iconv("\xA3\x00").should == "Đ".force_encoding('utf-8')
      @ansel.iconv("\xA4\x00").should == "Þ".force_encoding('utf-8')
      @ansel.iconv("\xA5\x00").should == "Æ".force_encoding('utf-8')
      @ansel.iconv("\xA6\x00").should == "Œ".force_encoding('utf-8')
      @ansel.iconv("\xA7\x00").should == "ʹ".force_encoding('utf-8')
      @ansel.iconv("\xA8\x00").should == "·".force_encoding('utf-8')
      @ansel.iconv("\xA9\x00").should == "♭".force_encoding('utf-8')
      @ansel.iconv("\xAA\x00").should == "®".force_encoding('utf-8')
      @ansel.iconv("\xAB\x00").should == "±".force_encoding('utf-8')
      @ansel.iconv("\xAB\x00").should == "±".force_encoding('utf-8')
      @ansel.iconv("\xAC\x00").should == "Ơ".force_encoding('utf-8')
      @ansel.iconv("\xAD\x00").should == "Ư".force_encoding('utf-8')
      @ansel.iconv("\xAE\x00").should == "ʼ".force_encoding('utf-8')
      @ansel.iconv("\xB0\x00").should == "ʻ".force_encoding('utf-8')
      @ansel.iconv("\xB1\x00").should == "ł".force_encoding('utf-8')
      @ansel.iconv("\xB2\x00").should == "ø".force_encoding('utf-8')
      @ansel.iconv("\xB3\x00").should == "đ".force_encoding('utf-8')
      @ansel.iconv("\xB4\x00").should == "þ".force_encoding('utf-8')
      @ansel.iconv("\xB5\x00").should == "æ".force_encoding('utf-8')
      @ansel.iconv("\xB6\x00").should == "œ".force_encoding('utf-8')
      @ansel.iconv("\xB7\x00").should == "ʺ".force_encoding('utf-8')
      @ansel.iconv("\xB8\x00").should == "ı".force_encoding('utf-8')
      @ansel.iconv("\xB9\x00").should == "£".force_encoding('utf-8')
      @ansel.iconv("\xBA\x00").should == "ð".force_encoding('utf-8')
      @ansel.iconv("\xBC\x00").should == "ơ".force_encoding('utf-8')
      @ansel.iconv("\xBD\x00").should == "ư".force_encoding('utf-8')
      @ansel.iconv("\xC0\x00").should == "°".force_encoding('utf-8')
      @ansel.iconv("\xC1\x00").should == "ℓ".force_encoding('utf-8')
      @ansel.iconv("\xC2\x00").should == "℗".force_encoding('utf-8')
      @ansel.iconv("\xC3\x00").should == "©".force_encoding('utf-8')
      @ansel.iconv("\xC4\x00").should == "♯".force_encoding('utf-8')
      @ansel.iconv("\xC5\x00").should == "¿".force_encoding('utf-8')
      @ansel.iconv("\xC6\x00").should == "¡".force_encoding('utf-8')
      @ansel.iconv("\xC7\x00").should == "ß".force_encoding('utf-8')
      @ansel.iconv("\xC8\x00").should == "€".force_encoding('utf-8')
    
      # ANSEL combining characters
      @ansel.iconv("\xE0\x41").should == "Ả".force_encoding('utf-8')
      @ansel.iconv("\xF6\x4C").should == "Ḻ".force_encoding('utf-8')
      @ansel.iconv("\xF6").should == "̲".force_encoding('utf-8')
      @ansel.iconv("\xF9").should == "̮".force_encoding('utf-8')
      @ansel.iconv("\xF9\x48").should == "Ḫ".force_encoding('utf-8')
      @ansel.iconv("\xF2\xE3\x41").should == "Ậ".force_encoding('utf-8')
      @ansel.iconv("\xF2\x79").should == "ỵ".force_encoding('utf-8')
      @ansel.iconv("\xF2").should == "̣".force_encoding('utf-8')
    end
    
    it "converts full text correctly" do
      @ansel.iconv("What is the question?").should == "What is the question?"
      @ansel.iconv("\xC5\x00What is the question?").should == "¿What is the question?".force_encoding('utf-8')
      @ansel.iconv("\xC3\x00 1994").should == "© 1994".force_encoding('utf-8')
      @ansel.iconv("\xB9\x004.59").should == "£4.59".force_encoding('utf-8')
    end

    it "converts ANSEL to UTF-16" do
      converter = ANSEL::Iconv.new 'UTF-16', 'ANSEL'
      converter.iconv('abc').should == "\376\377\000a\000b\000c"
    end

    it "converts ASCII to UTF-16" do
      converter = ANSEL::Iconv.new 'UTF-16', 'ASCII'
      converter.iconv('abc').should == "\376\377\000a\000b\000c"
    end

    it "converts UTF-8 to UTF-16" do
      converter = ANSEL::Iconv.new 'UTF-16', 'UTF-8'
      converter.iconv('abc').should == "\376\377\000a\000b\000c"
    end

    it "converts UTF-16 to UTF-16" do
      converter = ANSEL::Iconv.new 'UTF-16', 'UTF-16'
      converter.iconv("\376\377\000a\000b\000c").should == "\376\377\000a\000b\000c"
    end
  end
end