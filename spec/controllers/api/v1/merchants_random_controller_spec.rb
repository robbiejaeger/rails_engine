require 'rails_helper'

RSpec.describe Api::V1::Merchants::RandomController, type: :controller do
  render_views

  describe "returns random merchant" do
    it 'returns a single merchant' do
      customers = create_list(:merchant, 3)

      get :show, params: {format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to_not be_nil
      expect(result["name"]).to_not be_nil
    end
  end
end
