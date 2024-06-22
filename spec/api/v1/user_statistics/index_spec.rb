require 'rails_helper'

RSpec.describe "user_statistics#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/user_statistics", params: params
  end

  describe 'basic fetch' do
    let!(:user_statistic1) { create(:user_statistic) }
    let!(:user_statistic2) { create(:user_statistic) }

    it 'works' do
      expect(UserStatisticResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['user_statistics'])
      expect(d.map(&:id)).to match_array([user_statistic1.id, user_statistic2.id])
    end
  end
end
