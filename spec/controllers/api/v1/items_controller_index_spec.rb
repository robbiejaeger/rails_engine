require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do
  render_views

  describe "find a collection of items" do
    it 'returns a single item if only one exists' do
      item = create(:item)

      get :index, params: {id: item.id, format: :json}
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

    it 'returns multiple items searching by name' do
      items = create_list(:item, 3)

      get :index, params: {format: :json}
      result_array = JSON.parse(response.body)
      expect(3).to eq(result_array.length)

      result_array.each_with_index do |result, n|
        expect(result["name"]).to eq(items[n].name)
        expect(result["description"]).to eq(items[n].description)
        expect(result["unit_price"]).to eq("150.50")
        expect(result["merchant_id"]).to eq(items[n].merchant_id)
        expect(result["created_at"]).to eq(nil)
        expect(result["updated_at"]).to eq(nil)
      end
    end
  end
end
