require 'minitest'
require 'minitest/autorun'
require './lib/key'

class KeyTest < Minitest::Test
  def test_accepts_entry_on_creation
    testkey = Key.new(25326, "010101")
    assert testkey
  end

  def test_key_splits_supplied_keynum_into_rotations
    testkey = Key.new(25326, "010101")
    assert_equal [25, 53, 32, 26], testkey.rotations
  end

  def test_key_pulls_offsets_from_supplied_date
    testkey = Key.new(25326, "140415")
    assert_equal [2, 2, 2, 5], testkey.offsets
  end

  def test_creates_string_from_today
    testkey = Key.new
    assert_equal Time.new.strftime("%d%m%y"), testkey.todaystring
  end

  def test_pulls_offsets_from_unsupplied_date
    testkey = Key.new
    assert_equal [2, 2, 2, 5], testkey.offsets
  end

  def test_creates_valid_rotations_from_random_keynum
    testkey = Key.new
    testrotations = testkey.rotations
    assert_equal 4, testkey.rotations.length
    assert testrotations.is_a?(Array)
  end

  def test_revolver_is_rotations_plus_offsets
    testkey = Key.new(25326, "140415")
    testkey.create_revolver
    assert_equal [27, 55, 34, 31], testkey.revolver
  end
end