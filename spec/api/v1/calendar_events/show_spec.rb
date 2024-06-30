require 'rails_helper'

RSpec.describe "calendar_events#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/calendar_events/#{calendar_event.id}", params: params
  end

  describe 'basic fetch' do
    let!(:calendar_event) { create(:calendar_event) }

    it 'works' do
      expect(CalendarEventResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('calendar_events')
      expect(d.id).to eq(calendar_event.id)
    end
  end
end
