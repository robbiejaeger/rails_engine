require 'rails_helper'

RSpec.describe Api::V1::Transactions::InvoicesController, type: :controller do
  render_views

  describe "find a single invoice associated with a transaction" do
    it 'returns a single invoice' do
      invoice = create(:invoice)
      transaction = create(:transaction, invoice_id: invoice.id)

      get :show, params: {transaction_id: transaction.id, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(invoice.id)
      expect(result["status"]).to eq(invoice.status)
      expect(result["customer_id"]).to eq(invoice.customer_id)
      expect(result["merchant_id"]).to eq(invoice.merchant_id)
      expect(result["created_at"]).to eq(nil)
      expect(result["updated_at"]).to eq(nil)
    end
  end
end
