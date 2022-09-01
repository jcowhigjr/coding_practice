require_relative "test_helper"
# require 'minitest/focus'
require "my_kata_3"

class ProjectTest < ActiveSupport::TestCase
  include Test
  test "the truth" do
    assert_equal(0, Test.minimal_number_of_packages(0, 1, 1))
    assert_equal(0, Test.minimal_number_of_packages(0, 0, 0))
    assert_equal(1, Test.minimal_number_of_packages(5, 1, 0))
    assert_equal(1, Test.minimal_number_of_packages(1, 0, 1))
    assert_equal(1, Test.minimal_number_of_packages(1, 1, 1))
    assert_equal(2, Test.minimal_number_of_packages(6, 1, 1))
    assert_equal(2, Test.minimal_number_of_packages(2, 1, 2))
    assert_equal(-1, Test.minimal_number_of_packages(4, 0, 3))
    assert_equal(-1, Test.minimal_number_of_packages(6, 1, 0))
    assert_equal(-1, Test.minimal_number_of_packages(4, 1, 0))
    assert_equal(8, Test.minimal_number_of_packages(16, 2, 10))
  end
end
