require 'rails_helper'

RSpec.describe Api::V1::InvoiceItems::RandomController, type: :controller do
  render_views

  describe "returns random invoice item" do
    it 'returns a single invoice item' do
      customers = create_list(:invoice_item, 3)

      get :show, params: {format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to_not be_nil
      expect(result["item_id"]).to_not be_nil
      expect(result["invoice_id"]).to_not be_nil
      expect(result["quantity"]).to_not be_nil
      expect(result["unit_price"]).to_not be_nil
    end
  end
end
