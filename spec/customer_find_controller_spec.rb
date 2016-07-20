require 'rails_helper'

RSpec.describe Api::V1::Customers::FindController, type: :controller do
  render_views

  describe "find a customer when multiple customers exist" do
    it 'finds customer by id' do
      customers = create_list(:customer, 3)

      get :show, params: {id: customers[0].id, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(customers[0].id)
      expect(result["first_name"]).to eq(customers[0].first_name)
      expect(result["last_name"]).to eq(customers[0].last_name)
    end
  end
end
