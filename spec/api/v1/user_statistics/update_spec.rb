require 'rails_helper'

RSpec.describe "user_statistics#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/user_statistics/#{user_statistic.id}", payload
  end

  describe 'basic update' do
    let!(:user_statistic) { create(:user_statistic) }

    let(:payload) do
      {
        data: {
          id: user_statistic.id.to_s,
          type: 'user_statistics',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(UserStatisticResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { user_statistic.reload.attributes }
    end
  end
end
