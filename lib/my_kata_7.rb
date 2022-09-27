module Test
  class CountrySubdivision
    attr_reader :json, :id, :code, :code_ansi, :code_iso, :name, :country_id

    def initialize(json:, args: {})
      @json = json
      # @id = json["id"]
      # @code = json["code"]
      # @code_ansi = json["code_ansi"]
      # @code_iso = json["code_iso"]
      # @name = json["name"]
      # @country_id = json["country_id"]
    end

    def subdivisions
      @json.map do |subdivision|
        CountrySubdivision.new(json: subdivision)
      end
    end

    # select first subdivision
    def self.first
      @subdivisions_array.first
    end

    def ordered_by_name
      states = []
      @json.each do |country_subdivision|
        state = country_subdivision["name"]
        states << state
      end
      states.sort
    end

    # ordered states with 3 vales in the name
    def states_with_3_different_vales_in_the_name
      lowercase_vales = ["a", "e", "i", "o", "u"]
      states_with_vales = []
      states = ordered_by_name
      states.each do |state|
        # convert to lowercase
        state_downcased = state.downcase
        # make array of letters
        state_letters = state_downcased.chars
        # make unique array of letters
        state_unique_letters = state_letters.uniq
        included_vales = []
        state_unique_letters.each do |letter|
          if lowercase_vales.include?(letter)
            included_vales << letter
          end
        end
        states_with_vales << state if included_vales.count == 3
      end
      states_with_vales
    end
  end
end
