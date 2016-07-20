require 'rails_helper'

RSpec.describe Api::V1::InvoiceItems::ItemsController, type: :controller do
  render_views

  describe "returns item for an invoice item" do
    it 'returns item' do
      invoice_item = create(:invoice_item)

      get :show, params: {invoice_item_id: invoice_item.id, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(invoice_item.item.id)
    end
  end
end
