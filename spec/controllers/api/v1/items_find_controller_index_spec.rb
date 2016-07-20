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
    end

    it 'returns multiple items searching by name' do
      items = create_list(:item, 3)
      items = items + create_list(:item, 3, name: "Fantastic Plastic Table")

      get :index, params: {name: "Fantastic Plastic Table", format: :json}
      result_array = JSON.parse(response.body)
      expect(3).to eq(result_array.length)

      result_array.each_with_index do |result, n|
        expect(result["name"]).to eq(items[n+3].name)
        expect(result["description"]).to eq(items[n+3].description)
        expect(result["unit_price"]).to eq(items[n+3].unit_price)
        expect(result["merchant_id"]).to eq(items[n+3].merchant_id)
      end
    end

    it 'returns multiple items searching by description' do
      items = create_list(:item, 3)
      items = items + create_list(:item, 3, description: "No home should be without one")

      get :index, params: {description: "No home should be without one", format: :json}
      result_array = JSON.parse(response.body)
      expect(3).to eq(result_array.length)

      result_array.each_with_index do |result, n|
        expect(result["name"]).to eq(items[n+3].name)
        expect(result["description"]).to eq(items[n+3].description)
        expect(result["unit_price"]).to eq(items[n+3].unit_price)
        expect(result["merchant_id"]).to eq(items[n+3].merchant_id)
      end
    end

    it 'returns multiple items searching by unit_price' do
      items = create_list(:item, 3)
      items = items + create_list(:item, 3, unit_price: 1475)

      get :index, params: {unit_price: 14.75, format: :json}
      result_array = JSON.parse(response.body)
      expect(3).to eq(result_array.length)

      result_array.each_with_index do |result, n|
        expect(result["name"]).to eq(items[n+3].name)
        expect(result["description"]).to eq(items[n+3].description)
        expect(result["unit_price"]).to eq(items[n+3].unit_price)
        expect(result["merchant_id"]).to eq(items[n+3].merchant_id)
      end
    end

    it 'returns multiple items searching by merchant_id' do
      items = create_list(:item, 3)
      merchant = create(:merchant)
      items = items + create_list(:item, 3, merchant_id: merchant.id)

      get :index, params: {merchant_id: merchant.id, format: :json}
      result_array = JSON.parse(response.body)
      expect(3).to eq(result_array.length)

      result_array.each_with_index do |result, n|
        expect(result["name"]).to eq(items[n+3].name)
        expect(result["description"]).to eq(items[n+3].description)
        expect(result["unit_price"]).to eq(items[n+3].unit_price)
        expect(result["merchant_id"]).to eq(items[n+3].merchant_id)
      end
    end
  end
end
