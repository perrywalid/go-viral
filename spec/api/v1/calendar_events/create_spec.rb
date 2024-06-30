require 'rails_helper'

RSpec.describe "calendar_events#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/calendar_events", payload
  end

  describe 'basic create' do
    let(:params) do
      attributes_for(:calendar_event)
    end
    let(:payload) do
      {
        data: {
          type: 'calendar_events',
          attributes: params
        }
      }
    end

    it 'works' do
      expect(CalendarEventResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { CalendarEvent.count }.by(1)
    end
  end
end
