require 'rails_helper'

RSpec.describe "calendar_events#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/calendar_events/#{calendar_event.id}", payload
  end

  describe 'basic update' do
    let!(:calendar_event) { create(:calendar_event) }

    let(:payload) do
      {
        data: {
          id: calendar_event.id.to_s,
          type: 'calendar_events',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(CalendarEventResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { calendar_event.reload.attributes }
    end
  end
end
