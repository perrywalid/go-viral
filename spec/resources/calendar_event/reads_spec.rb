require 'rails_helper'

RSpec.describe CalendarEventResource, type: :resource do
  describe 'serialization' do
    let!(:calendar_event) { create(:calendar_event) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(calendar_event.id)
      expect(data.jsonapi_type).to eq('calendar_events')
    end
  end

  describe 'filtering' do
    let!(:calendar_event1) { create(:calendar_event) }
    let!(:calendar_event2) { create(:calendar_event) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: calendar_event2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([calendar_event2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:calendar_event1) { create(:calendar_event) }
      let!(:calendar_event2) { create(:calendar_event) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            calendar_event1.id,
            calendar_event2.id
          ])
        end
      end

      context 'when descending' do
        before do
          params[:sort] = '-id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            calendar_event2.id,
            calendar_event1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
