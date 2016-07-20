require 'rails_helper'

RSpec.describe Api::V1::Invoices::TransactionsController, type: :controller do
  render_views

  describe "returns transactions for an invoice" do
    it 'returns list of all transactions' do
      transaction_1 = create(:transaction)
      transaction_2 = create(:transaction, result: "failure")

      get :index, params: {invoice_id: transaction_1.invoice.id, format: :json}
      result = JSON.parse(response.body)

      expect(result.count).to eq(1)
      expect(result[0]["id"]).to eq(transaction_1.id)
      expect(result[0]["credit_card_number"]).to eq(transaction_1.credit_card_number)
      expect(result[0]["result"]).to eq(transaction_1.result)
    end
  end
end
