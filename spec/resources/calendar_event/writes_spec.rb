require 'rails_helper'

RSpec.describe CalendarEventResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'calendar_events',
          attributes: attributes_for(:calendar_event)
        }
      }
    end

    let(:instance) do
      CalendarEventResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { CalendarEvent.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:calendar_event) { create(:calendar_event) }

    let(:payload) do
      {
        data: {
          id: calendar_event.id.to_s,
          type: 'calendar_events',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      CalendarEventResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { calendar_event.reload.updated_at }
      # .and change { calendar_event.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:calendar_event) { create(:calendar_event) }

    let(:instance) do
      CalendarEventResource.find(id: calendar_event.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { CalendarEvent.count }.by(-1)
    end
  end
end
