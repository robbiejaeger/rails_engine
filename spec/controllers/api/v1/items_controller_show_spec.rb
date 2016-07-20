require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do
  render_views

  describe "find a single item when multiple items exist" do
    it 'finds an item by id' do
      items = create_list(:item, 3)

      get :show, params: {id: items[0].id, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(items[0].id)
      expect(result["name"]).to eq(items[0].name)
      expect(result["description"]).to eq(items[0].description)
      expect(result["unit_price"]).to eq("150.50")
      expect(result["merchant_id"]).to eq(items[0].merchant_id)
      expect(result["created_at"]).to eq(nil)
      expect(result["updated_at"]).to eq(nil)
    end
  end
end
