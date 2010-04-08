# encoding: ascii-8bit

require 'test_helper'

class ANSEL::IconvTest < Test::Unit::TestCase
  FIXTURE_PATH = File.dirname(__FILE__) + "/../../../fixtures/gedcom"
  
  def setup
    @ansel = ANSEL::Iconv.new 'UTF-8'
  end
  
  should "return ASCII values without conversion" do
    assert_equal " ", @ansel.iconv("\x20")
    assert_equal "x", @ansel.iconv("\x78")
  end
  
  should "return the unicode replacement character for invalid characters" do
    assert_equal "�".force_encoding('utf-8'), @ansel.iconv("\xBE\x00")
    assert_equal "�".force_encoding('utf-8'), @ansel.iconv("\xD1\x00")
  end
  
  should "return UTF-8 characters for valid ANSEL characters" do
    # ANSEL non-combining mappings
    assert_equal "", @ansel.iconv("\x88\x00")
    assert_equal "", @ansel.iconv("\x89\x00")
    assert_equal "", @ansel.iconv("\x8D\x00")
    assert_equal "", @ansel.iconv("\x8E\x00")
    assert_equal "Ł".force_encoding('utf-8'), @ansel.iconv("\xA1\x00")
    assert_equal "Ø".force_encoding('utf-8'), @ansel.iconv("\xA2\x00")
    assert_equal "Đ".force_encoding('utf-8'), @ansel.iconv("\xA3\x00")
    assert_equal "Þ".force_encoding('utf-8'), @ansel.iconv("\xA4\x00")
    assert_equal "Æ".force_encoding('utf-8'), @ansel.iconv("\xA5\x00")
    assert_equal "Œ".force_encoding('utf-8'), @ansel.iconv("\xA6\x00")
    assert_equal "ʹ".force_encoding('utf-8'), @ansel.iconv("\xA7\x00")
    assert_equal "·".force_encoding('utf-8'), @ansel.iconv("\xA8\x00")
    assert_equal "♭".force_encoding('utf-8'), @ansel.iconv("\xA9\x00")
    assert_equal "®".force_encoding('utf-8'), @ansel.iconv("\xAA\x00")
    assert_equal "±".force_encoding('utf-8'), @ansel.iconv("\xAB\x00")
    assert_equal "±".force_encoding('utf-8'), @ansel.iconv("\xAB\x00")
    assert_equal "Ơ".force_encoding('utf-8'), @ansel.iconv("\xAC\x00")
    assert_equal "Ư".force_encoding('utf-8'), @ansel.iconv("\xAD\x00")
    assert_equal "ʼ".force_encoding('utf-8'), @ansel.iconv("\xAE\x00")
    assert_equal "ʻ".force_encoding('utf-8'), @ansel.iconv("\xB0\x00")
    assert_equal "ł".force_encoding('utf-8'), @ansel.iconv("\xB1\x00")
    assert_equal "ø".force_encoding('utf-8'), @ansel.iconv("\xB2\x00")
    assert_equal "đ".force_encoding('utf-8'), @ansel.iconv("\xB3\x00")
    assert_equal "þ".force_encoding('utf-8'), @ansel.iconv("\xB4\x00")
    assert_equal "æ".force_encoding('utf-8'), @ansel.iconv("\xB5\x00")
    assert_equal "œ".force_encoding('utf-8'), @ansel.iconv("\xB6\x00")
    assert_equal "ʺ".force_encoding('utf-8'), @ansel.iconv("\xB7\x00")
    assert_equal "ı".force_encoding('utf-8'), @ansel.iconv("\xB8\x00")
    assert_equal "£".force_encoding('utf-8'), @ansel.iconv("\xB9\x00")
    assert_equal "ð".force_encoding('utf-8'), @ansel.iconv("\xBA\x00")
    assert_equal "ơ".force_encoding('utf-8'), @ansel.iconv("\xBC\x00")
    assert_equal "ư".force_encoding('utf-8'), @ansel.iconv("\xBD\x00")
    assert_equal "°".force_encoding('utf-8'), @ansel.iconv("\xC0\x00")
    assert_equal "ℓ".force_encoding('utf-8'), @ansel.iconv("\xC1\x00")
    assert_equal "℗".force_encoding('utf-8'), @ansel.iconv("\xC2\x00")
    assert_equal "©".force_encoding('utf-8'), @ansel.iconv("\xC3\x00")
    assert_equal "♯".force_encoding('utf-8'), @ansel.iconv("\xC4\x00")
    assert_equal "¿".force_encoding('utf-8'), @ansel.iconv("\xC5\x00")
    assert_equal "¡".force_encoding('utf-8'), @ansel.iconv("\xC6\x00")
    assert_equal "ß".force_encoding('utf-8'), @ansel.iconv("\xC7\x00")
    assert_equal "€".force_encoding('utf-8'), @ansel.iconv("\xC8\x00")
    
    # ANSEL combining characters
    assert_equal "Ả".force_encoding('utf-8'), @ansel.iconv("\xE0\x41")
    assert_equal "Ḻ".force_encoding('utf-8'), @ansel.iconv("\xF6\x4C")
    assert_equal "̲".force_encoding('utf-8'), @ansel.iconv("\xF6")
    assert_equal "̮".force_encoding('utf-8'), @ansel.iconv("\xF9")
    assert_equal "Ḫ".force_encoding('utf-8'), @ansel.iconv("\xF9\x48")
    assert_equal "Ậ".force_encoding('utf-8'), @ansel.iconv("\xF2\xE3\x41")
    assert_equal "ỵ".force_encoding('utf-8'), @ansel.iconv("\xF2\x79")
    assert_equal "̣".force_encoding('utf-8'), @ansel.iconv("\xF2")
  end
  
  should "convert full text correctly" do
    assert_equal "What is the question?", @ansel.iconv("What is the question?")
    assert_equal "¿What is the question?".force_encoding('utf-8'), @ansel.iconv("\xC5\x00What is the question?")
    assert_equal "© 1994".force_encoding('utf-8'), @ansel.iconv("\xC3\x00 1994")
    assert_equal "£4.59".force_encoding('utf-8'), @ansel.iconv("\xB9\x004.59")
  end
  
  should "convert ANSEL to UTF-16" do
    converter = ANSEL::Iconv.new 'UTF-16', 'ANSEL'
    assert_equal "\376\377\000a\000b\000c", converter.iconv('abc')
  end
  
  should "convert ASCII to UTF-16" do
    converter = ANSEL::Iconv.new 'UTF-16', 'ASCII'
    assert_equal "\376\377\000a\000b\000c", converter.iconv('abc')
  end
  
  should "convert UTF-8 to UTF-16" do
    converter = ANSEL::Iconv.new 'UTF-16', 'UTF-8'
    assert_equal "\376\377\000a\000b\000c", converter.iconv('abc')
  end
  
  should "convert UTF-16 to UTF-16" do
    converter = ANSEL::Iconv.new 'UTF-16', 'UTF-16'
    assert_equal "\376\377\000a\000b\000c", converter.iconv("\376\377\000a\000b\000c")
  end
end