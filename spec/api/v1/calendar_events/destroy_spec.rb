require 'rails_helper'

RSpec.describe "calendar_events#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/calendar_events/#{calendar_event.id}"
  end

  describe 'basic destroy' do
    let!(:calendar_event) { create(:calendar_event) }

    it 'updates the resource' do
      expect(CalendarEventResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { CalendarEvent.count }.by(-1)
      expect { calendar_event.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
