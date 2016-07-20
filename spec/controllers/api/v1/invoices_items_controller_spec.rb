require 'rails_helper'

RSpec.describe Api::V1::Invoices::ItemsController, type: :controller do
  render_views

  describe "returns items for an invoice" do
    it 'returns list of items' do
      invoice_1 = create(:invoice)
      invoice_1.invoice_items << create_list(:invoice_item, 2)

      get :index, params: {invoice_id: invoice_1.id, format: :json}
      result = JSON.parse(response.body)

      expect(result.count).to eq(2)
      expect(result[0]["id"]).to eq(invoice_1.items[0].id)
    end
  end
end
