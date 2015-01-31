# encoding: ascii-8bit

require 'spec_helper'

describe ANSEL::Iconv do
  before do
    @ansel = ANSEL::Converter.new
  end

  describe '#iconv' do

    it "does not convert ASCII characters" do
      expect(@ansel.convert("\x20")).to eq ' '
      expect(@ansel.convert("\x78")).to eq 'x'
    end

    it 'converts invalid characters to the unicode replacement character' do
      expect(@ansel.convert("\xBE\x00")).to eq "�".force_encoding('utf-8')
      expect(@ansel.convert("\xD1\x00")).to eq "�".force_encoding('utf-8')
    end

    it 'converts valid ANSEL characters to UTF-8 equivalents' do
      # ANSEL non-combining mappings
      expect(@ansel.convert("\x88\x00")).to eq ''
      expect(@ansel.convert("\x89\x00")).to eq ''
      expect(@ansel.convert("\x8D\x00")).to eq ''
      expect(@ansel.convert("\x8E\x00")).to eq ''
      expect(@ansel.convert("\xA1\x00")).to eq "Ł".force_encoding('utf-8')
      expect(@ansel.convert("\xA2\x00")).to eq "Ø".force_encoding('utf-8')
      expect(@ansel.convert("\xA3\x00")).to eq "Đ".force_encoding('utf-8')
      expect(@ansel.convert("\xA4\x00")).to eq "Þ".force_encoding('utf-8')
      expect(@ansel.convert("\xA5\x00")).to eq "Æ".force_encoding('utf-8')
      expect(@ansel.convert("\xA6\x00")).to eq "Œ".force_encoding('utf-8')
      expect(@ansel.convert("\xA7\x00")).to eq "ʹ".force_encoding('utf-8')
      expect(@ansel.convert("\xA8\x00")).to eq "·".force_encoding('utf-8')
      expect(@ansel.convert("\xA9\x00")).to eq "♭".force_encoding('utf-8')
      expect(@ansel.convert("\xAA\x00")).to eq "®".force_encoding('utf-8')
      expect(@ansel.convert("\xAB\x00")).to eq "±".force_encoding('utf-8')
      expect(@ansel.convert("\xAB\x00")).to eq "±".force_encoding('utf-8')
      expect(@ansel.convert("\xAC\x00")).to eq "Ơ".force_encoding('utf-8')
      expect(@ansel.convert("\xAD\x00")).to eq "Ư".force_encoding('utf-8')
      expect(@ansel.convert("\xAE\x00")).to eq "ʼ".force_encoding('utf-8')
      expect(@ansel.convert("\xB0\x00")).to eq "ʻ".force_encoding('utf-8')
      expect(@ansel.convert("\xB1\x00")).to eq "ł".force_encoding('utf-8')
      expect(@ansel.convert("\xB2\x00")).to eq "ø".force_encoding('utf-8')
      expect(@ansel.convert("\xB3\x00")).to eq "đ".force_encoding('utf-8')
      expect(@ansel.convert("\xB4\x00")).to eq "þ".force_encoding('utf-8')
      expect(@ansel.convert("\xB5\x00")).to eq "æ".force_encoding('utf-8')
      expect(@ansel.convert("\xB6\x00")).to eq "œ".force_encoding('utf-8')
      expect(@ansel.convert("\xB7\x00")).to eq "ʺ".force_encoding('utf-8')
      expect(@ansel.convert("\xB8\x00")).to eq "ı".force_encoding('utf-8')
      expect(@ansel.convert("\xB9\x00")).to eq "£".force_encoding('utf-8')
      expect(@ansel.convert("\xBA\x00")).to eq "ð".force_encoding('utf-8')
      expect(@ansel.convert("\xBC\x00")).to eq "ơ".force_encoding('utf-8')
      expect(@ansel.convert("\xBD\x00")).to eq "ư".force_encoding('utf-8')
      expect(@ansel.convert("\xC0\x00")).to eq "°".force_encoding('utf-8')
      expect(@ansel.convert("\xC1\x00")).to eq "ℓ".force_encoding('utf-8')
      expect(@ansel.convert("\xC2\x00")).to eq "℗".force_encoding('utf-8')
      expect(@ansel.convert("\xC3\x00")).to eq "©".force_encoding('utf-8')
      expect(@ansel.convert("\xC4\x00")).to eq "♯".force_encoding('utf-8')
      expect(@ansel.convert("\xC5\x00")).to eq "¿".force_encoding('utf-8')
      expect(@ansel.convert("\xC6\x00")).to eq "¡".force_encoding('utf-8')
      expect(@ansel.convert("\xC7\x00")).to eq "ß".force_encoding('utf-8')
      expect(@ansel.convert("\xC8\x00")).to eq "€".force_encoding('utf-8')

      # ANSEL combining characters
      expect(@ansel.convert("\xE0\x41")).to eq "Ả".force_encoding('utf-8')
      expect(@ansel.convert("\xF6\x4C")).to eq "Ḻ".force_encoding('utf-8')
      expect(@ansel.convert("\xF6")).to eq "̲".force_encoding('utf-8')
      expect(@ansel.convert("\xF9")).to eq "̮".force_encoding('utf-8')
      expect(@ansel.convert("\xF9\x48")).to eq "Ḫ".force_encoding('utf-8')
      expect(@ansel.convert("\xF2\xE3\x41")).to eq "Ậ".force_encoding('utf-8')
      expect(@ansel.convert("\xF2\x79")).to eq "ỵ".force_encoding('utf-8')
      expect(@ansel.convert("\xF2")).to eq "̣".force_encoding('utf-8')
    end

    it "converts full text correctly" do
      expect(@ansel.convert("What is the question?")).to eq "What is the question?"
      expect(@ansel.convert("\xC5\x00What is the question?")).to eq "¿What is the question?".force_encoding('utf-8')
      expect(@ansel.convert("\xC3\x00 1994")).to eq "© 1994".force_encoding('utf-8')
      expect(@ansel.convert("\xB9\x004.59")).to eq "£4.59".force_encoding('utf-8')
    end

  end
end
