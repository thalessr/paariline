# frozen_string_literal: true

class Activity < ApplicationRecord

  belongs_to :owner, class_name: 'User'

  validates :source_id, :source_name, :description, :happened_at, presence: true

end
