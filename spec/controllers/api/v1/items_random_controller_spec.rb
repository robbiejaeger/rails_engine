require 'rails_helper'

RSpec.describe Api::V1::Items::RandomController, type: :controller do
  render_views

  describe "returns random item" do
    it 'returns a single item' do
      customers = create_list(:item, 3)

      get :show, params: {format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to_not be_nil
      expect(result["name"]).to_not be_nil
      expect(result["description"]).to_not be_nil
      expect(result["merchant_id"]).to_not be_nil
      expect(result["unit_price"]).to_not be_nil
    end
  end
end
