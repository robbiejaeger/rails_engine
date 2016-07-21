require 'rails_helper'

RSpec.describe Api::V1::Merchants::MostRevenueController, type: :controller do
  render_views

  describe "find a merchant when only one exists" do
    it 'returns single merchant when only one exists' do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      item = create(:item, merchant_id: merchant.id)
      invoice_item = create(:invoice_item, item_id: item.id, invoice_id: invoice.id, quantity: 2, unit_price: 15050)
      transaction = create(:transaction, invoice_id: invoice.id)

      get :index, params: {quantity: 1, format: :json}
      result_array = JSON.parse(response.body)
      result = result_array[0]

      expect(result["id"]).to eq(merchant.id)
      expect(result["name"]).to eq(merchant.name)
    end
  end

  describe "find result when multiple merchants exist" do
    it 'returns a list of merchants with multiple merchants' do
      customer = create(:customer)

      merchant1 = create(:merchant)
      invoice1 = create(:invoice, customer_id: customer.id, merchant_id: merchant1.id)
      item1 = create(:item, merchant_id: merchant1.id)
      invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id, quantity: 3, unit_price: 15050)
      transaction1 = create(:transaction, invoice_id: invoice1.id)


      merchant2 = create(:merchant)
      invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant2.id)
      item2 = create(:item, merchant_id: merchant2.id)
      invoice_item2 = create(:invoice_item, item_id: item2.id, invoice_id: invoice2.id, quantity: 1, unit_price: 15050)
      transaction2 = create(:transaction, invoice_id: invoice2.id)

      get :index, params: {quantity: 2, format: :json}
      result_array = JSON.parse(response.body)
      expect(2).to eq(result_array.length)

      expect(result_array[0]["id"]).to eq(merchant1.id)
      expect(result_array[0]["name"]).to eq(merchant1.name)
      expect(result_array[1]["id"]).to eq(merchant2.id)
      expect(result_array[1]["name"]).to eq(merchant2.name)
    end
  end
end
