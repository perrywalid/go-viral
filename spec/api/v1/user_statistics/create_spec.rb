require 'rails_helper'

RSpec.describe "user_statistics#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/user_statistics", payload
  end

  describe 'basic create' do
    let(:params) do
      attributes_for(:user_statistic)
    end
    let(:payload) do
      {
        data: {
          type: 'user_statistics',
          attributes: params
        }
      }
    end

    it 'works' do
      expect(UserStatisticResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { UserStatistic.count }.by(1)
    end
  end
end
