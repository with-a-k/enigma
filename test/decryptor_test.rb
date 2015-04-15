require 'minitest'
require 'minitest/autorun'
require './lib/decryptor'

class DecryptorTest < Minitest::Test
  def test_decryptors_exist_and_take_three_arguments
    assert Decryptor.new("sample text.", 25326, "140415")
  end

  def test_decryptors_make_their_own_key
    testdecryptor = Decryptor.new("sample text.", 25326, "140415")
    assert testdecryptor.key.is_a?(Key)
  end

  def test_decryptors_make_their_own_rotator
    testdecryptor = Decryptor.new("sample text.", 25326, "140415")
    assert testdecryptor.rotator.is_a?(Rotator)
  end

  def test_decryptors_store_their_text
    testdecryptor = Decryptor.new("gqhh,u5l5ao3", 25326, "140415")
    assert_equal "gqhh,u5l5ao3", testdecryptor.text
  end

  def test_decryptors_encrypt
    testdecryptor = Decryptor.new("gqhh,u5l5ao3", 25326, "140415")
    assert_equal "sample text.", testdecryptor.decrypt
  end

  def test_decryptors_encrypt_other_things
    testdecryptor = Decryptor.new("dumkcuid9scc5yo", 25326, "140415")
    assert_equal "persoenlichkeit", testdecryptor.decrypt
  end

  def test_very_long_key
    testdecryptor = Decryptor.new(", 9j emzw0k660eq6k2bqbas0j2143fqqdgjc7517dkj07jqq36 .i22a7k5q455,b9jada5x22pxi7q6j2n7ecythcj, 9jzh5zw0 u63dqqii6t6j060 m4b2u6jgjwh9m522n7kfpthqj7823x5gx47751ef", 56685, "150415")
    assert_equal "the round sun menu 2 light plane no weapons here abyss quest battle unite, descent bookmark the grand finale squadron fall into dream, boundary of recollection", testdecryptor.decrypt
  end
end