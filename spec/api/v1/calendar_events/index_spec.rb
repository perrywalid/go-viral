require 'rails_helper'

RSpec.describe "calendar_events#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/calendar_events", params: params
  end

  describe 'basic fetch' do
    let!(:calendar_event1) { create(:calendar_event) }
    let!(:calendar_event2) { create(:calendar_event) }

    it 'works' do
      expect(CalendarEventResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['calendar_events'])
      expect(d.map(&:id)).to match_array([calendar_event1.id, calendar_event2.id])
    end
  end
end
