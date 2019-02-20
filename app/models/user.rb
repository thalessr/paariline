# frozen_string_literal: true

class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :lockable,
         :rememberable, :validatable

  has_many :profile_pictures, dependent: :destroy, inverse_of: :user
  has_many :activities, foreign_key: :owner_id, inverse_of: :owner, dependent: :restrict_with_error

  validates :first_name, :last_name, presence: true, on: :update

  def full_name
    [first_name, last_name].select(&:present?).join(' ')
  end

  def new_pictures=(files)
    Array.wrap(files).each do |file|
      image = download_picture(file)
      filename = "#{Time.zone.now.strftime('%Y%m%d_%H%M%S')}_#{File.basename(file)}"
      profile_pictures.build.picture.attach(io: image, filename: filename, content_type: 'image/jpg')
    end
  end

  private

  def download_picture(file_url)
    response = Net::HTTP.get_response(URI.parse(file_url))
    StringIO.new(response.body)
  end

end
