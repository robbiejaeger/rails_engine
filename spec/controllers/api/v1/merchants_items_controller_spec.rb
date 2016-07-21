require 'rails_helper'

RSpec.describe Api::V1::Merchants::ItemsController, type: :controller do
  render_views

  describe "find a collection of items scoped to a merchant" do
    it 'returns a single item if only one exists' do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)

      get :index, params: {merchant_id: merchant.id, format: :json}

      result_array = JSON.parse(response.body)
      expect(1).to eq(result_array.length)
      result = result_array[0]

      expect(result["id"]).to eq(item.id)
      expect(result["name"]).to eq(item.name)
      expect(result["description"]).to eq(item.description)
      expect(result["unit_price"]).to eq("150.50")
      expect(result["merchant_id"]).to eq(item.merchant_id)
      expect(result["created_at"]).to eq(nil)
      expect(result["updated_at"]).to eq(nil)
    end

    it 'returns a single items scoped to the given merchant out of many' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      item1 = create(:item, merchant_id: merchant1.id)
      items = create_list(:item, 2, merchant_id: merchant2.id)


      get :index, params: {merchant_id: merchant1.id, format: :json}
      result_array = JSON.parse(response.body)
      expect(1).to eq(result_array.length)
      result = result_array[0]

      expect(result["name"]).to eq(item1.name)
      expect(result["description"]).to eq(item1.description)
      expect(result["unit_price"]).to eq("150.50")
      expect(result["merchant_id"]).to eq(merchant1.id)
      expect(result["created_at"]).to eq(nil)
      expect(result["updated_at"]).to eq(nil)
    end

    it 'returns multiple items, but only those scoped to the given merchant' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      items = create_list(:item, 3, merchant_id: merchant1.id)
      items = items + create_list(:item, 2, merchant_id: merchant2.id)


      get :index, params: {merchant_id: merchant1.id, format: :json}
      result_array = JSON.parse(response.body)
      expect(3).to eq(result_array.length)

      result_array.each_with_index do |result, n|
        expect(result["name"]).to eq(items[n].name)
        expect(result["description"]).to eq(items[n].description)
        expect(result["unit_price"]).to eq("150.50")
        expect(result["merchant_id"]).to eq(merchant1.id)
        expect(result["created_at"]).to eq(nil)
        expect(result["updated_at"]).to eq(nil)
      end
    end
  end
end
