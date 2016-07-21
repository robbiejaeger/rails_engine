require 'rails_helper'

RSpec.describe Api::V1::Invoices::RandomController, type: :controller do
  render_views

  describe "returns random invoice" do
    it 'returns a single invoice' do
      customers = create_list(:invoice, 3)

      get :show, params: {format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to_not be_nil
      expect(result["customer_id"]).to_not be_nil
      expect(result["merchant_id"]).to_not be_nil
      expect(result["status"]).to_not be_nil
    end
  end
end
