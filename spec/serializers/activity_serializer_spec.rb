# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ActivitySerializer, type: :model do
  let(:activity) { build_stubbed(:activity) }
  let(:activity_attributes) do
    { color: activity.color, description: activity.description, happened_at: activity.happened_at, icon: activity.icon }
  end

  def parse_datetime(datetime)
    Time.zone.parse(datetime)
  end

  describe 'serialized hash' do
    let(:serialized_hash) { ActivitySerializer.new(activity).serializable_hash }

    it { expect(serialized_hash[:data]).not_to be_empty }
    it { expect(serialized_hash[:data]).to be_instance_of(Hash) }
    it { expect(serialized_hash[:data][:id].to_i).to eq(activity.id) }
    it { expect(serialized_hash[:data][:attributes]).to match(activity_attributes) }
  end

  describe 'serialized hash' do
    let(:serialized_json) { JSON.parse(ActivitySerializer.new(activity).serialized_json, symbolize_names: true) }

    before { travel_to(Time.zone.local(2019, 0o2, 21, 10, 0o4, 0o0)) }

    after { travel_back }

    it { expect(serialized_json[:data]).not_to be_empty }
    it { expect(serialized_json[:data]).to be_instance_of(Hash) }
    it { expect(serialized_json[:data][:id].to_i).to eq(activity.id) }
    it do
      expect(
        serialized_json[:data][:attributes].except!(:happened_at)
      ).to match(activity_attributes.except!(:happened_at))
    end
    it do
      expect(
        parse_datetime(serialized_json.dig(:data, :attributes, :happened_at))
      ).to eq(parse_datetime(activity_attributes[:happened_at].to_s))
    end
  end
end
