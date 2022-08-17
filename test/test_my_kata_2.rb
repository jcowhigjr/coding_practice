require_relative 'test_helper'
# require 'minitest/focus'
require 'my_kata_2'

class ProjectTest < ActiveSupport::TestCase
  include Test

  test 'move_zeros' do
    assert_equal(Test.move_zeros([0, 1, 0, 3, 12]), [1, 3, 12, 0, 0])
    assert_equal(Test.move_zeros([0]), [0])
  end

  test 'remove_element' do
    assert_equal(Test.remove_element([3, 2, 2, 3], 3), '2, nums = [2, 2]')
    assert_equal(Test.remove_element([3, 2, 2, 3], 2), '2, nums = [3, 3]')
    assert_equal(Test.remove_element([0, 1, 2, 2, 3, 0, 4, 2], 2), '5, nums = [0, 1, 3, 0, 4]')
  end
end
