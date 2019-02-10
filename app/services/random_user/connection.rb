# frozen_string_literal: true

module RandomUser
  class Connection

    attr_accessor :gender, :results

    def initialize(gender: nil, results: nil)
      @gender = gender
      @results = results
    end

    def request
      connection.get { |request| request.params.merge!(params.compact) }
    rescue Faraday::ClientError => ex
      logger.error(ex.message)
    end

    private

    def connection
      @connection ||= Faraday.new(base_url) do |conn|
        conn.use Faraday::Response::Logger, logger
        conn.use Faraday::Response::RaiseError
        conn.use Faraday::Adapter::NetHttp
      end
    end

    def logger
      @logger ||= Logger.new(Rails.root.join('log', 'random_user.log'))
    end

    def params
      {}.tap do |param|
        param['gender'] = gender
        param['password'] = 'upper,8-128'
        param['exc'] = 'registered,phone,cell'
        param['results'] = results
      end
    end

    def base_url
      'https://randomuser.me/api/'
    end

  end
end
