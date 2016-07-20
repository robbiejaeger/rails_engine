require 'rails_helper'

RSpec.describe Api::V1::InvoiceItems::FindController, type: :controller do
  render_views

  describe "find a collection of invoice_items when multiple invoice_items exist" do
    it 'returns a single invoice_item if only one matches. Search by id' do
      invoice_items = create_list(:invoice_item, 3)

      get :index, params: {id: invoice_items[0].id, format: :json}
      result_array = JSON.parse(response.body)
      expect(1).to eq(result_array.length)
      result = result_array[0]

      expect(result["id"]).to eq(invoice_items[0].id)
      expect(result["item_id"]).to eq(invoice_items[0].item_id)
      expect(result["invoice_id"]).to eq(invoice_items[0].invoice_id)
      expect(result["quantity"]).to eq(invoice_items[0].quantity)
      expect(result["unit_price"]).to eq(invoice_items[0].unit_price)
      expect(result["id"]).not_to eq(invoice_items[1].id)
      expect(result["created_at"]).to eq(nil)
      expect(result["updated_at"]).to eq(nil)
    end

    it 'returns multiple invoice_items searching by item_id' do
      invoice_items = create_list(:invoice_item, 3)
      item = create(:item)
      invoice_items = invoice_items + create_list(:invoice_item, 3, item_id: item.id)

      get :index, params: {item_id: item.id, format: :json}
      result_array = JSON.parse(response.body)
      expect(3).to eq(result_array.length)

      result_array.each_with_index do |result, n|
        expect(result["item_id"]).to eq(item.id)
        expect(result["invoice_id"]).to eq(invoice_items[n+3].invoice_id)
        expect(result["quantity"]).to eq(invoice_items[n+3].quantity)
        expect(result["unit_price"]).to eq(invoice_items[n+3].unit_price)
        expect(result["created_at"]).to eq(nil)
        expect(result["updated_at"]).to eq(nil)
      end
    end

    it 'returns multiple invoice_items searching by invoice_id' do
      invoice_items = create_list(:invoice_item, 3)
      invoice = create(:invoice)
      invoice_items = invoice_items + create_list(:invoice_item, 3, invoice_id: invoice.id)

      get :index, params: {invoice_id: invoice.id, format: :json}
      result_array = JSON.parse(response.body)
      expect(3).to eq(result_array.length)

      result_array.each_with_index do |result, n|
        expect(result["item_id"]).to eq(invoice_items[n+3].item_id)
        expect(result["invoice_id"]).to eq(invoice.id)
        expect(result["quantity"]).to eq(invoice_items[n+3].quantity)
        expect(result["unit_price"]).to eq(invoice_items[n+3].unit_price)
        expect(result["created_at"]).to eq(nil)
        expect(result["updated_at"]).to eq(nil)
      end
    end

    it 'returns multiple invoice_items searching by quantity' do
      invoice_items = create_list(:invoice_item, 3)
      merchant = create(:merchant)
      invoice_items = invoice_items + create_list(:invoice_item, 3, quantity: 15)

      get :index, params: {quantity: 15, format: :json}
      result_array = JSON.parse(response.body)
      expect(3).to eq(result_array.length)

      result_array.each_with_index do |result, n|
        expect(result["item_id"]).to eq(invoice_items[n+3].item_id)
        expect(result["invoice_id"]).to eq(invoice_items[n+3].invoice_id)
        expect(result["quantity"]).to eq(15)
        expect(result["unit_price"]).to eq(invoice_items[n+3].unit_price)
        expect(result["created_at"]).to eq(nil)
        expect(result["updated_at"]).to eq(nil)
      end
    end

    it 'returns multiple invoice_items searching by unit_price' do
      invoice_items = create_list(:invoice_item, 3)
      merchant = create(:merchant)
      invoice_items = invoice_items + create_list(:invoice_item, 3, unit_price: 1275)

      get :index, params: {unit_price: 12.75, format: :json}
      result_array = JSON.parse(response.body)
      expect(3).to eq(result_array.length)

      result_array.each_with_index do |result, n|
        expect(result["item_id"]).to eq(invoice_items[n+3].item_id)
        expect(result["invoice_id"]).to eq(invoice_items[n+3].invoice_id)
        expect(result["quantity"]).to eq(invoice_items[n+3].quantity)
        expect(result["unit_price"]).to eq(1275)
        expect(result["created_at"]).to eq(nil)
        expect(result["updated_at"]).to eq(nil)
      end
    end
  end
end
