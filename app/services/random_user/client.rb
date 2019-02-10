# frozen_string_literal: true

module RandomUser
  class Client

    attr_accessor :quantity, :gender
    attr_reader :connection

    def initialize
      @connection = RandomUser::Connection.new
    end

    def profiles
      [].tap do |array|
        results.each do |result|
          array << RandomUser::Profile.new(result)
        end
      end
    end

    private

    def fetch_random_user
      connection.results = quantity
      connection.gender = gender
      @fetch_random_user ||= connection.request
    end

    def raw_response
      @raw_response ||= JSON.parse(fetch_random_user.body, symbolize_names: true)
    end

    def results
      @results ||= Array.wrap(raw_response[:results])
    end

  end
end
