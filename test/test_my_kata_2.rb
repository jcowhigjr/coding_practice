require_relative "test_helper"
# require 'minitest/focus'
require "my_kata_2"

class ProjectTest < ActiveSupport::TestCase
  include Test

  test "move_zeros" do
    assert_equal([1, 3, 12, 0, 0], Test.move_zeros([0, 1, 0, 3, 12]))
    assert_equal([1, 3, 0, 0, 0], Test.move_zeros([0, 1, 0, 3, 0]))

    assert_equal([0], Test.move_zeros([0]))
  end
  # Finished tests in 0.006291s, 158.9572 tests/s, 476.8717 assertions/s.

  test "move_zeros_select" do
    assert_equal([1, 3, 12, 0, 0], Test.move_zeros_select([0, 1, 0, 3, 12]))
    assert_equal([1, 3, 0, 0, 0], Test.move_zeros_select([0, 1, 0, 3, 0]))

    assert_equal([0], Test.move_zeros_select([0]))
  end
  # Finished tests in 0.002110s, 473.9336 tests/s, 1421.8009 assertions/s.

  test "remove_element" do
    assert_equal("2, nums = [2, 2]", Test.remove_element([3, 2, 2, 3], 3))
    assert_equal("2, nums = [3, 3]", Test.remove_element([3, 2, 2, 3], 2))
    assert_equal("5, nums = [0, 1, 3, 0, 4]", Test.remove_element([0, 1, 2, 2, 3, 0, 4, 2], 2))
  end
end
