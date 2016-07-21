require 'rails_helper'

RSpec.describe Api::V1::Merchants::MostItemsController, type: :controller do
  render_views

  describe "find a list of merchants" do
    it 'returns single merchant when only one exists' do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merchant.id)
      invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      invoice_item = create(:invoice_item, item_id: item.id,
                            invoice_id: invoice.id, quantity: 2, unit_price: 15050)
      transaction = create(:transaction, invoice_id: invoice.id)

      get :index, params: {quantity: 1, format: :json}
      result_array = JSON.parse(response.body)
      expect(1).to eq(result_array.length)
      result = result_array[0]

      expect(result["id"]).to eq(merchant.id)
      expect(result["name"]).to eq(merchant.name)
    end

    it 'returns multiple merchants' do
      customer = create(:customer)
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)
      # 3 items
      item1 = create(:item, merchant_id: merchant1.id)
      invoice1 = create(:invoice, customer_id: customer.id, merchant_id: merchant1.id)
      invoice_item1 = create(:invoice_item, item_id: item1.id,
                            invoice_id: invoice1.id, quantity: 3, unit_price: 15050)
      transaction1 = create(:transaction, invoice_id: invoice1.id)
      # 2 items
      item2 = create(:item, merchant_id: merchant2.id)
      invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant2.id)
      invoice_item2 = create(:invoice_item, item_id: item2.id,
                            invoice_id: invoice2.id, quantity: 2, unit_price: 15050)
      transaction2 = create(:transaction, invoice_id: invoice2.id)
      # 1 items
      item3 = create(:item, merchant_id: merchant3.id)
      invoice3 = create(:invoice, customer_id: customer.id, merchant_id: merchant3.id)
      invoice_item3 = create(:invoice_item, item_id: item3.id,
                            invoice_id: invoice3.id, quantity: 1, unit_price: 15050)
      transaction3 = create(:transaction, invoice_id: invoice3.id)

      get :index, params: {quantity: 3, format: :json}
      result_array = JSON.parse(response.body)
      expect(3).to eq(result_array.length)

      expect(result_array[0]["id"]).to eq(merchant1.id)
      expect(result_array[0]["name"]).to eq(merchant1.name)
      expect(result_array[1]["id"]).to eq(merchant2.id)
      expect(result_array[1]["name"]).to eq(merchant2.name)
      expect(result_array[2]["id"]).to eq(merchant3.id)
      expect(result_array[2]["name"]).to eq(merchant3.name)
    end
  end
end
