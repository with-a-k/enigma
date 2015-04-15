require 'minitest'
require 'minitest/autorun'
require './lib/rotator'
require './lib/key'

class RotatorTest < Minitest::Test
  def test_rotators_exist
    testkey = Key.new(25326, "140415")
    assert Rotator.new(testkey)
  end

  def test_rotator_inherits_revolver_from_key
    testkey = Key.new(25326, "140415")
    testrotator = Rotator.new(testkey)
    assert_equal [27, 55, 34, 31], testrotator.rotations
  end

  def test_rotator_changes_text_according_to_revolver
    testkey = Key.new(25326, "140415")
    testrotator = Rotator.new(testkey)
    assert_equal "gqhh,u5l5ao3", testrotator.rotate_forwards("sample text.")
  end

  def test_different_sample_text
    testkey = Key.new(25326, "140415")
    testrotator = Rotator.new(testkey)
    assert_equal "dumkcuid9scc5yo", testrotator.rotate_forwards("persoenlichkeit")
  end

  def test_rotator_can_rotate_backwards
    testkey = Key.new(25326, "140415")
    testrotator = Rotator.new(testkey)
    assert_equal "sample text.", testrotator.rotate_backwards("gqhh,u5l5ao3")
  end

  def test_rotate_something_else_backwards
    testkey = Key.new(25326, "140415")
    testrotator = Rotator.new(testkey)
    assert_equal "persoenlichkeit", testrotator.rotate_backwards("dumkcuid9scc5yo")
  end
end