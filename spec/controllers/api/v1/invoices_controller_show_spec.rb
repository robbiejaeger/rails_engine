require 'rails_helper'

RSpec.describe Api::V1::InvoicesController, type: :controller do
  render_views

  describe "find a single invoice when multiple invoices exist" do
    it 'finds an invoice by id' do
      invoices = create_list(:invoice, 3)

      get :show, params: {id: invoices[0].id, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(invoices[0].id)
      expect(result["customer_id"]).to eq(invoices[0].customer_id)
      expect(result["merchant_id"]).to eq(invoices[0].merchant_id)
      expect(result["status"]).to eq(invoices[0].status)
      expect(result["created_at"]).to eq(nil)
      expect(result["updated_at"]).to eq(nil)
    end
  end
end
