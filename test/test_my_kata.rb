require_relative "test_helper"
require "minitest/autorun"
# require 'minitest/focus'
require "my_kata"

class ProjectTest < ActiveSupport::TestCase
  include Test

  test "baord returns array" do
    assert_equal(Test::Game.new("3,1,0,2").board, [3, 1, 0, 2])
    assert_equal(Test::Game.new("").board, [])
  end

  # count the number of jumps to find a zero
  test "play_game_of_zero" do
    assert_equal(Test.play_game_of_zero("0,0,0,0"), 0)
    assert_equal(Test.play_game_of_zero("1,0,0,0"), 1)
    assert_equal(Test.play_game_of_zero("1,1,1,1"), -1)
    assert_equal(Test.play_game_of_zero("3,1,0,2"), 3)
    assert_equal(Test.play_game_of_zero("3,1,0,2,0"), 3)
  end
end
