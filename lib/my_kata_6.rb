module Test
  class CountrySubdivisionClient
    require "json"
    require "net/http"
    require "uri"
    attr_reader :response

    REQUEST_TIME_OUT_SECONDS = 5
    COUNTRY_ID = "4040f18e-84e2-4322-b41f-b2160c594406"

    CONFIG = {
      headers: '{"Accept" => "application/json"}',
      base_url: "https://api.carerev.com/api/v1",
      country_subdivisions_path: "/country_subdivisions",
      country_query_params: "country_id=#{COUNTRY_ID}",
      request_time_out_seconds: REQUEST_TIME_OUT_SECONDS
    }
    # object accepts request/response for testing
    def initialize(request: nil, response: nil)
      @request = request if request.is_a?(Net::HTTPRequest)
      @response = response if response.is_a?(Net::HTTPSuccess)
      @response ||= make_request unless response.is_a?(Net::HTTPSuccess)
    end

    def call
      last_response
    end

    def url
      @url ||= "#{CONFIG[:base_url]}#{CONFIG[:country_subdivisions_path]}"
    end

    def query_params
      # return the query params
      @query_params ||= "country_id=#{CONFIG[:country_id]}"
    end

    def uri
      @uri ||= URI.parse("#{url}?#{query_params}")
    end

    def port
      url.port || 443
    end

    def headers
      @headers ||= CONFIG[:headers]
    end

    def response_body
      # return the response body
      @response.body if valid_response?
    end

    def response_code
      # return the response code
      @response.code if valid_response?
    end

    def body_as_json(body: response.body)
      # return the response as JSON
      JSON.parse(body)
    rescue JSON::ParserError
      []
    end

    private

    def make_request
      # make the request
      # curl -X GET -- header ‘Accept: application/json’ ‘https://api.carerev.com/api/v1/country_subdivisions?country_id=4040f18e-84e2-4322-b41f-b2160c594406’
      Net::HTTP.get_response(uri)
    end

    def parse_response
      if valid_response?
        @response = last_response
      else
        []
      end
    end

    def valid_response?
      # validate the request
      # return true if valid
      last_response.is_a?(Net::HTTPSuccess)
      last_response.body != ""
    end

    def last_response
      make_request if @response.nil?
    end
  end
end
