require 'rails_helper'

RSpec.describe Api::V1::Merchants::RevenueDatesController, type: :controller do
  render_views

  describe "find revenue value for a date" do
    it 'when a single merchant exists' do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merchant.id)
      invoice = create(:invoice, customer_id: customer.id,
                      merchant_id: merchant.id, created_at: "2012-03-16 11:55:05")
      invoice_item = create(:invoice_item, item_id: item.id,
                            invoice_id: invoice.id, quantity: 2, unit_price: 15056)
      transaction = create(:transaction, invoice_id: invoice.id)

      get :show, params: {date: "2012-03-16 11:55:05", format: :json}
      result = JSON.parse(response.body)

      expect(result["total_revenue"]).to eq('301.12')
    end

    it 'when multiple merchants exist' do
      customer = create(:customer)
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)
      # 3 items
      item1 = create(:item, merchant_id: merchant1.id)
      invoice1 = create(:invoice, customer_id: customer.id,
                        merchant_id: merchant1.id, created_at: "2012-03-16 11:55:05")
      invoice_item1 = create(:invoice_item, item_id: item1.id,
                            invoice_id: invoice1.id, quantity: 3, unit_price: 15056)
      transaction1 = create(:transaction, invoice_id: invoice1.id)
      # 2 items
      item2 = create(:item, merchant_id: merchant2.id)
      invoice2 = create(:invoice, customer_id: customer.id,
                        merchant_id: merchant2.id, created_at: "2012-03-16 11:55:05")
      invoice_item2 = create(:invoice_item, item_id: item2.id,
                            invoice_id: invoice2.id, quantity: 2, unit_price: 15056)
      transaction2 = create(:transaction, invoice_id: invoice2.id)
      # 1 items
      item3 = create(:item, merchant_id: merchant3.id)
      invoice3 = create(:invoice, customer_id: customer.id,
                        merchant_id: merchant3.id, created_at: "2012-03-16 11:55:05")
      invoice_item3 = create(:invoice_item, item_id: item3.id,
                            invoice_id: invoice3.id, quantity: 1, unit_price: 15056)
      transaction3 = create(:transaction, invoice_id: invoice3.id)

      get :show, params: {date: "2012-03-16 11:55:05", format: :json}
      result = JSON.parse(response.body)

      expect(result["total_revenue"]).to eq("903.36")
    end
  end
end
