require 'rails_helper'

RSpec.describe Api::V1::InvoiceItemsController, type: :controller do
  render_views

  describe "find a single invoice_item when multiple invoice_items exist" do
    it 'finds an invoice_item by id' do
      invoice_items = create_list(:invoice_item, 3)

      get :show, params: {id: invoice_items[0].id, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(invoice_items[0].id)
      expect(result["item_id"]).to eq(invoice_items[0].item_id)
      expect(result["invoice_id"]).to eq(invoice_items[0].invoice_id)
      expect(result["quantity"]).to eq(invoice_items[0].quantity)
      expect(result["unit_price"]).to eq("150.50")
      expect(result["created_at"]).to eq(nil)
      expect(result["updated_at"]).to eq(nil)
    end
  end
end
