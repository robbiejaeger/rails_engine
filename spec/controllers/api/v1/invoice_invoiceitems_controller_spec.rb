require 'rails_helper'

RSpec.describe Api::V1::Invoices::InvoiceItemsController, type: :controller do
  render_views

  describe "returns invoice items for an invoice" do
    it 'returns list of all invoice items' do
      invoice_item_1 = create(:invoice_item)
      invoice_item_2 = create(:invoice_item)

      get :index, params: {invoice_id: invoice_item_1.invoice.id, format: :json}
      result = JSON.parse(response.body)

      expect(result.count).to eq(1)
      expect(result[0]["id"]).to eq(invoice_item_1.id)
      expect(result[0]["item_id"]).to eq(invoice_item_1.item_id)
      expect(result[0]["invoice_id"]).to eq(invoice_item_1.invoice_id)
      expect(result[0]["quantity"]).to eq(invoice_item_1.quantity)
      expect(result[0]["unit_price"]).to eq("150.50")
    end
  end
end
