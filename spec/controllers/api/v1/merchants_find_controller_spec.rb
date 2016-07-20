require 'rails_helper'

RSpec.describe Api::V1::Merchants::FindController, type: :controller do
  render_views

  describe "returns all merchants" do
    it 'returns list of all merchants with same created_at' do
      merchants = create_list(:merchant, 3, created_at: Date.today)
      merchant_odd = create(:merchant)

      get :index, params: {created_at: Date.today, format: :json}
      result = JSON.parse(response.body)

      expect(result.count).to eq(3)
      expect(result[0]["id"]).to eq(merchants[0].id)
      expect(result[0]["name"]).to eq(merchants[0].name)
    end
  end

  describe "find a merchant when multiple merchants exist" do
    it 'finds merchant by id' do
      merchants = create_list(:merchant, 3)

      get :show, params: {id: merchants[0].id, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(merchants[0].id)
      expect(result["name"]).to eq(merchants[0].name)
    end

    it 'finds merchant by name' do
      merchants = create_list(:merchant, 3)

      get :show, params: {name: merchants[0].name, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(merchants[0].id)
      expect(result["name"]).to eq(merchants[0].name)
    end
  end
end
