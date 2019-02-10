# frozen_string_literal: true

module RandomUser
  class Profile

    attr_reader :response

    def initialize(response)
      @response = response
    end

    def birth_date
      dob_date = response.dig(:dob, :date)
      @birth_date ||= Time.zone.parse(dob_date) if dob_date
    end

    def age
      @age ||= response.dig(:dob, :age)
    end

    def email
      @email ||= response[:email]
    end

    def password
      @password ||= response.dig(:login, :password)
    end

    def first_name
      @first_name ||= response.dig(:name, :first)
    end

    def last_name
      @last_name ||= response.dig(:name, :last)
    end

    def picture_large
      @picture_large ||= response.dig(:picture, :large)
    end

    def picture_medium
      @picture_medium ||= response.dig(:picture, :medium)
    end

    def picture_thumbnail
      @picture_thumbnail ||= response.dig(:picture, :thumbnail)
    end

    def city
      @city ||= response.dig(:location, :city)
    end

  end
end
