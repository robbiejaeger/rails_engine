require 'rails_helper'

RSpec.describe Api::V1::Items::InvoiceItemsController, type: :controller do
  render_views

  describe "returns invoice items for an item" do
    it 'returns invoices' do
      item = create(:item)
      item.invoice_items << create_list(:invoice_item, 3)

      get :index, params: {item_id: item.id, format: :json}
      result = JSON.parse(response.body)

      expect(result.count).to eq(3)
      expect(result[0]["id"]).to eq(item.invoice_items[0].id)
    end
  end
end
