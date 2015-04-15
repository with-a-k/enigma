require 'minitest'
require 'minitest/autorun'
require './lib/cracker'

class CrackerTest < Minitest::Test
  def test_crackers_exist_and_take_two_args
    assert Cracker.new("meaningless stuff", "140415")
  end

  def test_cracker_can_retrieve_a_revolver
    testcracker = Cracker.new("nov5sop", "140415")
    assert_equal [15, 16, 17, 18], testcracker.retrieve_revolver
  end

  def test_a_different_revolver
    testcracker = Cracker.new("zo,f4o6", "140415")
    assert_equal [27, 16, 34, 31], testcracker.retrieve_revolver
  end

  def test_returns_all_zero_revolver_if_eos_is_invalid
    testcracker = Cracker.new("zo,f4p6", "140415")
    assert_equal [0, 0, 0, 0], testcracker.retrieve_revolver
  end

  def test_on_a_longer_string
    testcracker = Cracker.new("dumkcuid9scc5yo3zui8zo", "140415")
    assert_equal [27, 16, 34, 31], testcracker.retrieve_revolver
  end

  def test_on_a_different_longer_string
    testcracker = Cracker.new("gqhh,u5l5aop3o69bt63", "140415")
    assert_equal [27, 16, 34, 31], testcracker.retrieve_revolver
  end

  def test_revolvers_can_retrieve_keys
    testcracker = Cracker.new("zo,f4o6", "140415")
    testcracker.reconstruct_key
    assert_equal 25326, testcracker.cracked_key.keystr.to_i
  end
end