# encoding: ascii-8bit

require 'spec_helper'

describe ANSEL::Iconv do
  before do
    @ansel = ANSEL::Converter.new
  end

  describe '#iconv' do

    it "does not convert ASCII characters" do
      @ansel.convert("\x20").should == ' '
      @ansel.convert("\x78").should == 'x'
    end

    it 'converts invalid characters to the unicode replacement character' do
      @ansel.convert("\xBE\x00").should == "�".force_encoding('utf-8')
      @ansel.convert("\xD1\x00").should == "�".force_encoding('utf-8')
    end

    it 'converts valid ANSEL characters to UTF-8 equivalents' do
      # ANSEL non-combining mappings
      @ansel.convert("\x88\x00").should == ''
      @ansel.convert("\x89\x00").should == ''
      @ansel.convert("\x8D\x00").should == ''
      @ansel.convert("\x8E\x00").should == ''
      @ansel.convert("\xA1\x00").should == "Ł".force_encoding('utf-8')
      @ansel.convert("\xA2\x00").should == "Ø".force_encoding('utf-8')
      @ansel.convert("\xA3\x00").should == "Đ".force_encoding('utf-8')
      @ansel.convert("\xA4\x00").should == "Þ".force_encoding('utf-8')
      @ansel.convert("\xA5\x00").should == "Æ".force_encoding('utf-8')
      @ansel.convert("\xA6\x00").should == "Œ".force_encoding('utf-8')
      @ansel.convert("\xA7\x00").should == "ʹ".force_encoding('utf-8')
      @ansel.convert("\xA8\x00").should == "·".force_encoding('utf-8')
      @ansel.convert("\xA9\x00").should == "♭".force_encoding('utf-8')
      @ansel.convert("\xAA\x00").should == "®".force_encoding('utf-8')
      @ansel.convert("\xAB\x00").should == "±".force_encoding('utf-8')
      @ansel.convert("\xAB\x00").should == "±".force_encoding('utf-8')
      @ansel.convert("\xAC\x00").should == "Ơ".force_encoding('utf-8')
      @ansel.convert("\xAD\x00").should == "Ư".force_encoding('utf-8')
      @ansel.convert("\xAE\x00").should == "ʼ".force_encoding('utf-8')
      @ansel.convert("\xB0\x00").should == "ʻ".force_encoding('utf-8')
      @ansel.convert("\xB1\x00").should == "ł".force_encoding('utf-8')
      @ansel.convert("\xB2\x00").should == "ø".force_encoding('utf-8')
      @ansel.convert("\xB3\x00").should == "đ".force_encoding('utf-8')
      @ansel.convert("\xB4\x00").should == "þ".force_encoding('utf-8')
      @ansel.convert("\xB5\x00").should == "æ".force_encoding('utf-8')
      @ansel.convert("\xB6\x00").should == "œ".force_encoding('utf-8')
      @ansel.convert("\xB7\x00").should == "ʺ".force_encoding('utf-8')
      @ansel.convert("\xB8\x00").should == "ı".force_encoding('utf-8')
      @ansel.convert("\xB9\x00").should == "£".force_encoding('utf-8')
      @ansel.convert("\xBA\x00").should == "ð".force_encoding('utf-8')
      @ansel.convert("\xBC\x00").should == "ơ".force_encoding('utf-8')
      @ansel.convert("\xBD\x00").should == "ư".force_encoding('utf-8')
      @ansel.convert("\xC0\x00").should == "°".force_encoding('utf-8')
      @ansel.convert("\xC1\x00").should == "ℓ".force_encoding('utf-8')
      @ansel.convert("\xC2\x00").should == "℗".force_encoding('utf-8')
      @ansel.convert("\xC3\x00").should == "©".force_encoding('utf-8')
      @ansel.convert("\xC4\x00").should == "♯".force_encoding('utf-8')
      @ansel.convert("\xC5\x00").should == "¿".force_encoding('utf-8')
      @ansel.convert("\xC6\x00").should == "¡".force_encoding('utf-8')
      @ansel.convert("\xC7\x00").should == "ß".force_encoding('utf-8')
      @ansel.convert("\xC8\x00").should == "€".force_encoding('utf-8')

      # ANSEL combining characters
      @ansel.convert("\xE0\x41").should == "Ả".force_encoding('utf-8')
      @ansel.convert("\xF6\x4C").should == "Ḻ".force_encoding('utf-8')
      @ansel.convert("\xF6").should == "̲".force_encoding('utf-8')
      @ansel.convert("\xF9").should == "̮".force_encoding('utf-8')
      @ansel.convert("\xF9\x48").should == "Ḫ".force_encoding('utf-8')
      @ansel.convert("\xF2\xE3\x41").should == "Ậ".force_encoding('utf-8')
      @ansel.convert("\xF2\x79").should == "ỵ".force_encoding('utf-8')
      @ansel.convert("\xF2").should == "̣".force_encoding('utf-8')
    end

    it "converts full text correctly" do
      @ansel.convert("What is the question?").should == "What is the question?"
      @ansel.convert("\xC5\x00What is the question?").should == "¿What is the question?".force_encoding('utf-8')
      @ansel.convert("\xC3\x00 1994").should == "© 1994".force_encoding('utf-8')
      @ansel.convert("\xB9\x004.59").should == "£4.59".force_encoding('utf-8')
    end

  end
end
