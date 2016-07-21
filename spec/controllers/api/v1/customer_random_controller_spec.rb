require 'rails_helper'

RSpec.describe Api::V1::Customers::RandomController, type: :controller do
  render_views

  describe "returns random customer" do
    it 'returns a single customer' do
      customers = create_list(:customer, 3)

      get :show, params: {format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to_not be_nil
      expect(result["first_name"]).to_not be_nil
      expect(result["last_name"]).to_not be_nil
    end
  end
end
