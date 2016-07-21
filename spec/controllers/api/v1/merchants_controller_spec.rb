require 'rails_helper'

RSpec.describe Api::V1::MerchantsController, type: :controller do
  render_views

  describe "find a collection of merchants" do
    it 'returns a single merchant if only one exists' do
      merchant = create(:merchant)

      get :index, params: {id: merchant.id, format: :json}
      result_array = JSON.parse(response.body)
      expect(1).to eq(result_array.length)
      result = result_array[0]

      expect(result["id"]).to eq(merchant.id)
      expect(result["name"]).to eq(merchant.name)
      expect(result["created_at"]).to eq(nil)
      expect(result["updated_at"]).to eq(nil)
    end

    it 'returns multiple merchants when more than one exists' do
      merchants = create_list(:merchant, 3)

      get :index, params: {format: :json}
      result_array = JSON.parse(response.body)
      expect(3).to eq(result_array.length)

      result_array.each_with_index do |result, n|
        expect(result["id"]).to eq(merchants[n].id)
        expect(result["name"]).to eq(merchants[n].name)
        expect(result["created_at"]).to eq(nil)
        expect(result["updated_at"]).to eq(nil)
      end
    end
    describe "find a specific merchant" do
      it 'finds a merchant when one exists' do
        merchant = create(:merchant)
        get :show, params: {id: merchant.id, format: :json}
        result = JSON.parse(response.body)

        expect(result["id"]).to eq(merchant.id)
        expect(result["name"]).to eq(merchant.name)
        expect(result["created_at"]).to eq(nil)
        expect(result["updated_at"]).to eq(nil)
      end

      it 'finds a merchant when several exist' do
        merchant = create_list(:merchant, 3)
        get :show, params: {id: merchant[0].id, format: :json}
        result = JSON.parse(response.body)

        expect(result["id"]).to eq(merchant[0].id)
        expect(result["name"]).to eq(merchant[0].name)
        expect(result["created_at"]).to eq(nil)
        expect(result["updated_at"]).to eq(nil)
      end
    end
  end
end
