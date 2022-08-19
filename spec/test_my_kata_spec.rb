# require_relative 'test_helper'
require "rspec"
require "my_kata"
# require

describe "Test" do
  it "Fixed tests" do
    include Test
    assert_equals(Test.make_negative(42), -42)
  end
end
