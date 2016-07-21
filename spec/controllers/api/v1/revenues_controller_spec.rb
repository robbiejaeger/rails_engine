require 'rails_helper'

RSpec.describe Api::V1::Merchants::RevenuesController, type: :controller do
  render_views

  describe "find revenue value for a merchant on a date" do
    it 'when a single merchant exists' do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merchant.id)

      invoice1 = create(:invoice, customer_id: customer.id,
                        merchant_id: merchant.id, created_at: "2012-03-16 11:55:05")
      invoice_item1 = create(:invoice_item, item_id: item.id,
                            invoice_id: invoice1.id, quantity: 2, unit_price: 15056)
      transaction1 = create(:transaction, invoice_id: invoice1.id)

      invoice2 = create(:invoice, customer_id: customer.id,
                        merchant_id: merchant.id, created_at: "2012-03-16 11:55:05")
      invoice_item2 = create(:invoice_item, item_id: item.id,
                            invoice_id: invoice2.id, quantity: 2, unit_price: 15056)
      transaction2 = create(:transaction, invoice_id: invoice2.id)

      get :show, params: {merchant_id: merchant.id,
                          date: "2012-03-16 11:55:05", format: :json}
      result = JSON.parse(response.body)

      expect(result["revenue"]).to eq('602.24')
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

      get :show, params: {merchant_id: merchant1.id,
                          date: "2012-03-16 11:55:05", format: :json}
      result = JSON.parse(response.body)

      expect(result["revenue"]).to eq("451.68")
    end
  end



  describe "find revenue value for a merchant across all transactions" do
    it 'when a single merchant exists' do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merchant.id)

      invoice1 = create(:invoice, customer_id: customer.id,
                        merchant_id: merchant.id, created_at: "2012-03-16 11:55:05")
      invoice_item1 = create(:invoice_item, item_id: item.id,
                            invoice_id: invoice1.id, quantity: 2, unit_price: 15056)
      transaction1 = create(:transaction, invoice_id: invoice1.id)

      invoice2 = create(:invoice, customer_id: customer.id,
                        merchant_id: merchant.id, created_at: "2012-03-14 11:55:05")
      invoice_item2 = create(:invoice_item, item_id: item.id,
                            invoice_id: invoice2.id, quantity: 2, unit_price: 15056)
      transaction2 = create(:transaction, invoice_id: invoice2.id)

      get :show, params: {merchant_id: merchant.id, format: :json}
      result = JSON.parse(response.body)

      expect(result["revenue"]).to eq('602.24')
    end

    it 'when multiple merchants exist' do
      customer = create(:customer)
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)
      # 7 items
      item1 = create(:item, merchant_id: merchant1.id)
      invoice1 = create(:invoice, customer_id: customer.id,
                        merchant_id: merchant1.id, created_at: "2012-03-16 11:55:05")
      invoice_item1 = create(:invoice_item, item_id: item1.id,
                            invoice_id: invoice1.id, quantity: 3, unit_price: 15056)
      transaction1 = create(:transaction, invoice_id: invoice1.id)

      item4 = create(:item, merchant_id: merchant1.id)
      invoice4 = create(:invoice, customer_id: customer.id,
                        merchant_id: merchant1.id, created_at: "2012-03-14 11:55:05")
      invoice_item4 = create(:invoice_item, item_id: item4.id,
                            invoice_id: invoice4.id, quantity: 4, unit_price: 15056)
      transaction1 = create(:transaction, invoice_id: invoice4.id)
      # 2 items
      item2 = create(:item, merchant_id: merchant2.id)
      invoice2 = create(:invoice, customer_id: customer.id,
                        merchant_id: merchant2.id, created_at: "2012-03-15 11:55:05")
      invoice_item2 = create(:invoice_item, item_id: item2.id,
                            invoice_id: invoice2.id, quantity: 2, unit_price: 15056)
      transaction2 = create(:transaction, invoice_id: invoice2.id)
      # 1 items
      item3 = create(:item, merchant_id: merchant3.id)
      invoice3 = create(:invoice, customer_id: customer.id,
                        merchant_id: merchant3.id, created_at: "2012-03-14 11:55:05")
      invoice_item3 = create(:invoice_item, item_id: item3.id,
                            invoice_id: invoice3.id, quantity: 1, unit_price: 15056)
      transaction3 = create(:transaction, invoice_id: invoice3.id)

      get :show, params: {merchant_id: merchant1.id, format: :json}
      result = JSON.parse(response.body)

      expect(result["revenue"]).to eq("1053.92")
    end
  end
end
