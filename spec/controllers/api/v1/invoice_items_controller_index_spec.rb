require 'rails_helper'

RSpec.describe Api::V1::InvoiceItemsController, type: :controller do
  render_views

  describe "find a collection of invoice_items" do
    it 'returns a single invoice_item if only one exists' do
      invoice_item = create(:invoice_item)

      get :index, params: {id: invoice_item.id, format: :json}
      result_array = JSON.parse(response.body)
      expect(1).to eq(result_array.length)
      result = result_array[0]

      expect(result["id"]).to eq(invoice_item.id)
      expect(result["item_id"]).to eq(invoice_item.item_id)
      expect(result["invoice_id"]).to eq(invoice_item.invoice_id)
      expect(result["quantity"]).to eq(invoice_item.quantity)
      expect(result["unit_price"]).to eq("150.50")
      expect(result["created_at"]).to eq(nil)
      expect(result["updated_at"]).to eq(nil)
    end

    it 'returns multiple invoice_items when more than one exists' do
      invoice_items = create_list(:invoice_item, 3)

      get :index, params: {format: :json}
      result_array = JSON.parse(response.body)
      expect(3).to eq(result_array.length)

      result_array.each_with_index do |result, n|
        expect(result["item_id"]).to eq(invoice_items[n].item_id)
        expect(result["invoice_id"]).to eq(invoice_items[n].invoice_id)
        expect(result["quantity"]).to eq(invoice_items[n].quantity)
        expect(result["unit_price"]).to eq("150.50")
        expect(result["created_at"]).to eq(nil)
        expect(result["updated_at"]).to eq(nil)
      end
    end
  end
end
