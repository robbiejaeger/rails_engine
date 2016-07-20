require 'rails_helper'

RSpec.describe Api::V1::Items::FindController, type: :controller do
  render_views

  describe "find a collection of items when multiple items exist" do
    it 'returns a single item if only one matches. Search by id' do
      items = create_list(:item, 3)

      get :index, params: {id: items[0].id, format: :json}
      result_array = JSON.parse(response.body)
      expect(1).to eq(result_array.length)
      result = result_array[0]

      expect(result["id"]).to eq(items[0].id)
      expect(result["name"]).to eq(items[0].name)
      expect(result["description"]).to eq(items[0].description)
      expect(result["unit_price"]).to eq(items[0].unit_price)
      expect(result["merchant_id"]).to eq(items[0].merchant_id)
      expect(result["id"]).not_to eq(items[1].id)
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
        expect(result["unit_price"]).to eq(items[n].unit_price)
        expect(result["merchant_id"]).to eq(items[n].merchant_id)
        expect(result["created_at"]).to eq(nil)
        expect(result["updated_at"]).to eq(nil)
      end
    end
  end
end
