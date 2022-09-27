require_relative "test_helper"
require "minitest/autorun"
require "my_kata_7"
require "webmock/minitest"

class CountrySubdivisionTest < ActiveSupport::TestCase
  include Test
  require "json"

  setup do
    file = File.read("test/fixtures/country_subdivisions.json")
    @json = JSON.parse(file)
  end

  test "CountrySubdivision" do
    @country_subdivision = CountrySubdivision.new(json: @json)
    assert_equal @json, @country_subdivision.json
  end

  test "CountrySubdivision ordered_by_name" do
    @first_four = ["Alabama", "Alaska", "Arizona", "Arkansas"]
    @test = CountrySubdivision.new(json: @json).ordered_by_name
    assert_equal @first_four, @test.first(4)
  end

  test "CountrySubdivision states_with_3_different_vales_in_the_name" do
    @answer = ["Arizona",
      "California",
      "Florida",
      "Idaho",
      "Iowa",
      "Maine",
      "Massachusetts",
      "Missouri",
      "New Hampshire",
      "New Mexico",
      "North Carolina",
      "Pennsylvania",
      "South Dakota",
      "Washington",
      "West Virginia"]
    @test = CountrySubdivision.new(json: @json).states_with_3_different_vales_in_the_name
    assert_equal @answer, @test
  end
end
