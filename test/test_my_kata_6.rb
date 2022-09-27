require_relative "test_helper"
require "minitest/autorun"
require "my_kata_6"
require "webmock/minitest"

class ApiTest < ActiveSupport::TestCase
  setup do
    stub_request(:get, "https://api.carerev.com/api/v1/country_subdivisions?country_id=4040f18e-84e2-4322-b41f-b2160c594406")
      .with(
        headers: {
          "Host" => "api.carerev.com",
          "Accept" => "application/json"
        }
      )
      .to_return(status: 200, body: "{\"data_structure\":\"country_subdivisions\",\"href\":\"https://api.carerev.com/api/v1/country_subdivisi...",
        headers: {})
  end
  test "test real api functions like webmock" do
    # skip "test real api functions like webmock"
    response = Net::HTTP.get_response(URI.parse("https://api.carerev.com/api/v1/country_subdivisions?country_id=4040f18e-84e2-4322-b41f-b2160c594406"))
    assert_equal 200, response.code.to_i
    assert_equal "{\"data_structure\":\"country_subdivisions\",\"href\":\"https://api.carerev.com/api/v1/country_subdivisi...", response.body.truncate(100)
  end
end

class CountrySubdivisionClientTest < ActiveSupport::TestCase
  include Test
  require "vcr"
  VCR.configure do |c|
    c.cassette_library_dir = "spec/vcr"
    c.hook_into :webmock
    c.allow_http_connections_when_no_cassette = true
  end

  setup do
    @expected_response = VCR.use_cassette("carerev/country_subdivisions", re_record_interval: 300000) do
      Net::HTTP.get_response(URI.parse("https://api.carerev.com/api/v1/country_subdivisions?country_id=4040f18e-84e2-4322-b41f-b2160c594406"))
    end
  end

  test "Request VCR code is 200" do
    @expected_response.code == "200"
  end

  test "Request VCR body is not empty" do
    @expected_response.body != ""
  end

  test "CountrySubdivisionClient" do
    @client = CountrySubdivisionClient.new(response: @expected_response)
    assert_equal @expected_response, @client.response
    # assert_equal @expected_response.body, @client.response.body
  end

  test "CountrySubdivisionClient basic test" do
    @client = CountrySubdivisionClient.new(response: @expected_response)
    assert_equal @expected_response, @client.response
  end

  test "CountrySubdivisionClient accepts a config" do
    skip "not implemented"
  end
  test "CountrySubdivisionClient accepts a country query param" do
    skip "not implemented"
  end

  test "CountrySubdivisionClient parses the body to JSON" do
    @client = CountrySubdivisionClient.new(response: @expected_response)
    assert_equal String, @client.response.body.class
    assert_equal Hash, @client.body_as_json.class
  end
end
