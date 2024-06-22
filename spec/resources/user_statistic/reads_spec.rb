require 'rails_helper'

RSpec.describe UserStatisticResource, type: :resource do
  describe 'serialization' do
    let!(:user_statistic) { create(:user_statistic) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(user_statistic.id)
      expect(data.jsonapi_type).to eq('user_statistics')
    end
  end

  describe 'filtering' do
    let!(:user_statistic1) { create(:user_statistic) }
    let!(:user_statistic2) { create(:user_statistic) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: user_statistic2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([user_statistic2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:user_statistic1) { create(:user_statistic) }
      let!(:user_statistic2) { create(:user_statistic) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            user_statistic1.id,
            user_statistic2.id
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
            user_statistic2.id,
            user_statistic1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
