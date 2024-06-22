require 'rails_helper'

RSpec.describe "user_statistics#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/user_statistics/#{user_statistic.id}", params: params
  end

  describe 'basic fetch' do
    let!(:user_statistic) { create(:user_statistic) }

    it 'works' do
      expect(UserStatisticResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('user_statistics')
      expect(d.id).to eq(user_statistic.id)
    end
  end
end
