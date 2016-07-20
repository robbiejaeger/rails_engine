require 'rails_helper'

RSpec.describe Api::V1::Items::FindController, type: :controller do
  render_views

  describe "find a single item when multiple items exist" do
    it 'finds an item by id' do
      items = create_list(:item, 3)

      get :show, params: {id: items[0].id, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(items[0].id)
      expect(result["name"]).to eq(items[0].name)
      expect(result["description"]).to eq(items[0].description)
      expect(result["unit_price"]).to eq(items[0].unit_price)
      expect(result["merchant_id"]).to eq(items[0].merchant_id)
      expect(result["created_at"]).to eq(nil)
      expect(result["updated_at"]).to eq(nil)
    end

    it 'finds an item by name' do
      items = create_list(:item, 3)

      get :show, params: {name: items[1].name, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(items[1].id)
      expect(result["name"]).to eq(items[1].name)
      expect(result["description"]).to eq(items[1].description)
      expect(result["unit_price"]).to eq(items[1].unit_price)
      expect(result["merchant_id"]).to eq(items[1].merchant_id)
      expect(result["created_at"]).to eq(nil)
      expect(result["updated_at"]).to eq(nil)
    end

    it 'finds an item by description' do
      items = create_list(:item, 3)

      get :show, params: {description: items[1].description, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(items[1].id)
      expect(result["name"]).to eq(items[1].name)
      expect(result["description"]).to eq(items[1].description)
      expect(result["unit_price"]).to eq(items[1].unit_price)
      expect(result["merchant_id"]).to eq(items[1].merchant_id)
      expect(result["created_at"]).to eq(nil)
      expect(result["updated_at"]).to eq(nil)
    end

    it 'finds an item by unit_price' do
      items = create_list(:item, 2)
      uniq_price_item = create(:item, unit_price: 1050)

      get :show, params: {unit_price: 10.50, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(uniq_price_item.id)
      expect(result["name"]).to eq(uniq_price_item.name)
      expect(result["description"]).to eq(uniq_price_item.description)
      expect(result["unit_price"]).to eq(uniq_price_item.unit_price)
      expect(result["merchant_id"]).to eq(uniq_price_item.merchant_id)
      expect(result["created_at"]).to eq(nil)
      expect(result["updated_at"]).to eq(nil)
    end

    it 'returns the first of several items with the same price' do
      items = create_list(:item, 3)

      get :show, params: {unit_price: 150.50, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(items[0].id)
      expect(result["id"]).not_to eq(items[1].id)
    end


    it 'finds an item by merchant_id' do
      items = create_list(:item, 3)

      get :show, params: {merchant_id: items[1].merchant_id, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(items[1].id)
      expect(result["name"]).to eq(items[1].name)
      expect(result["description"]).to eq(items[1].description)
      expect(result["unit_price"]).to eq(items[1].unit_price)
      expect(result["merchant_id"]).to eq(items[1].merchant_id)
      expect(result["created_at"]).to eq(nil)
      expect(result["updated_at"]).to eq(nil)
    end
  end
end
