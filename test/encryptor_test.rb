require 'minitest'
require 'minitest/autorun'
require './lib/encryptor'

class EncryptorTest < Minitest::Test
  def test_encryptors_exist_and_take_three_arguments
    assert Encryptor.new("sample text.", 25326, "140415")
  end

  def test_encryptors_make_their_own_key
    testencryptor = Encryptor.new("sample text.", 25326, "140415")
    assert testencryptor.key.is_a?(Key)
  end

  def test_encryptors_make_their_own_rotator
    testencryptor = Encryptor.new("sample text.", 25326, "140415")
    assert testencryptor.rotator.is_a?(Rotator)
  end

  def test_encryptors_store_their_text
    testencryptor = Encryptor.new("sample text.", 25326, "140415")
    assert_equal "sample text.", testencryptor.text
  end

  def test_encryptors_encrypt
    testencryptor = Encryptor.new("sample text.", 25326, "140415")
    assert_equal "gqhh,u5l5ao3", testencryptor.encrypt
  end

  def test_encryptors_encrypt_other_things
    testencryptor = Encryptor.new("persoenlichkeit", 25326, "140415")
    assert_equal "dumkcuid9scc5yo", testencryptor.encrypt
  end
end