require 'rails_helper'

RSpec.describe UserStatisticResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'user_statistics',
          attributes: attributes_for(:user_statistic)
        }
      }
    end

    let(:instance) do
      UserStatisticResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { UserStatistic.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:user_statistic) { create(:user_statistic) }

    let(:payload) do
      {
        data: {
          id: user_statistic.id.to_s,
          type: 'user_statistics',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      UserStatisticResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { user_statistic.reload.updated_at }
      # .and change { user_statistic.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:user_statistic) { create(:user_statistic) }

    let(:instance) do
      UserStatisticResource.find(id: user_statistic.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { UserStatistic.count }.by(-1)
    end
  end
end
