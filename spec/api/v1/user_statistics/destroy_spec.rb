require 'rails_helper'

RSpec.describe "user_statistics#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/user_statistics/#{user_statistic.id}"
  end

  describe 'basic destroy' do
    let!(:user_statistic) { create(:user_statistic) }

    it 'updates the resource' do
      expect(UserStatisticResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { UserStatistic.count }.by(-1)
      expect { user_statistic.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
