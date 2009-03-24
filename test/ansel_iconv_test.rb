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
    assert_equal "\xEF\xBF\xBD", @ansel.iconv("\xBE\x00")
    assert_equal "\xEF\xBF\xBD", @ansel.iconv("\xD1\x00")
  end
  
  should "return UTF-8 characters for valid ANSEL characters" do
    # ANSEL non-combining mappings
    assert_equal "", @ansel.iconv("\x88\x00")
    assert_equal "", @ansel.iconv("\x89\x00")
    assert_equal "", @ansel.iconv("\x8D\x00")
    assert_equal "", @ansel.iconv("\x8E\x00")
    assert_equal "Ł", @ansel.iconv("\xA1\x00")
    assert_equal "Ø", @ansel.iconv("\xA2\x00")
    assert_equal "Đ", @ansel.iconv("\xA3\x00")
    assert_equal "Þ", @ansel.iconv("\xA4\x00")
    assert_equal "Æ", @ansel.iconv("\xA5\x00")
    assert_equal "Œ", @ansel.iconv("\xA6\x00")
    assert_equal "ʹ", @ansel.iconv("\xA7\x00")
    assert_equal "·", @ansel.iconv("\xA8\x00")
    assert_equal "♭", @ansel.iconv("\xA9\x00")
    assert_equal "®", @ansel.iconv("\xAA\x00")
    assert_equal "±", @ansel.iconv("\xAB\x00")
    assert_equal "±", @ansel.iconv("\xAB\x00")
    assert_equal "Ơ", @ansel.iconv("\xAC\x00")
    assert_equal "Ư", @ansel.iconv("\xAD\x00")
    assert_equal "ʼ", @ansel.iconv("\xAE\x00")
    assert_equal "ʻ", @ansel.iconv("\xB0\x00")
    assert_equal "ł", @ansel.iconv("\xB1\x00")
    assert_equal "ø", @ansel.iconv("\xB2\x00")
    assert_equal "đ", @ansel.iconv("\xB3\x00")
    assert_equal "þ", @ansel.iconv("\xB4\x00")
    assert_equal "æ", @ansel.iconv("\xB5\x00")
    assert_equal "œ", @ansel.iconv("\xB6\x00")
    assert_equal "ʺ", @ansel.iconv("\xB7\x00")
    assert_equal "ı", @ansel.iconv("\xB8\x00")
    assert_equal "£", @ansel.iconv("\xB9\x00")
    assert_equal "ð", @ansel.iconv("\xBA\x00")
    assert_equal "ơ", @ansel.iconv("\xBC\x00")
    assert_equal "ư", @ansel.iconv("\xBD\x00")
    assert_equal "°", @ansel.iconv("\xC0\x00")
    assert_equal "ℓ", @ansel.iconv("\xC1\x00")
    assert_equal "℗", @ansel.iconv("\xC2\x00")
    assert_equal "©", @ansel.iconv("\xC3\x00")
    assert_equal "♯", @ansel.iconv("\xC4\x00")
    assert_equal "¿", @ansel.iconv("\xC5\x00")
    assert_equal "¡", @ansel.iconv("\xC6\x00")
    assert_equal "ß", @ansel.iconv("\xC7\x00")
    assert_equal "€", @ansel.iconv("\xC8\x00")
    
    # ANSEL combining characters
    assert_equal "Ả", @ansel.iconv("\xE0\x41")
    assert_equal "Ḻ", @ansel.iconv("\xF6\x4C")
    assert_equal "̲", @ansel.iconv("\xF6")
    assert_equal "̮", @ansel.iconv("\xF9")
    assert_equal "Ḫ", @ansel.iconv("\xF9\x48")
    assert_equal "Ậ", @ansel.iconv("\xF2\xE3\x41")
    assert_equal "ỵ", @ansel.iconv("\xF2\x79")
    assert_equal "̣", @ansel.iconv("\xF2")
  end
  
  should "convert full text correctly" do
    assert_equal "What is the question?", @ansel.iconv("What is the question?")
    assert_equal "¿What is the question?", @ansel.iconv("\xC5\x00What is the question?")
    assert_equal "© 1994", @ansel.iconv("\xC3\x00 1994")
    assert_equal "£4.59", @ansel.iconv("\xB9\x004.59")
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