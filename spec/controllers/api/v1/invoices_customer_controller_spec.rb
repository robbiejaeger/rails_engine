require 'rails_helper'

RSpec.describe Api::V1::Invoices::CustomersController, type: :controller do
  render_views

  describe "returns customer for an invoice" do
    it 'returns customer' do
      invoice_1 = create(:invoice)

      get :show, params: {invoice_id: invoice_1.id, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(invoice_1.customer.id)
    end
  end
end
