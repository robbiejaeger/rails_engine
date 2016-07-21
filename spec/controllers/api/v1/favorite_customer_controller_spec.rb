require 'rails_helper'

RSpec.describe Api::V1::Merchants::FavoriteCustomerController, type: :controller do
  render_views

  describe "find a customer when only one customer exists" do
    it 'returns single customer when only one exists' do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      transaction = create(:transaction, invoice_id: invoice.id)

      get :show, params: {merchant_id: merchant.id, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(customer.id)
    end
  end

  describe "find a customer when multiple customers exist" do
    it 'returns a customer with multiple transactions' do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      invoice3 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      transaction1 = create(:transaction, invoice_id: invoice1.id)
      transaction2 = create(:transaction, invoice_id: invoice2.id)
      transaction3 = create(:transaction, invoice_id: invoice3.id)

      get :show, params: {merchant_id: merchant.id, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(customer.id)
    end

    it 'returns one of multiple customers' do
      merchant = create(:merchant)
      # 3 success transactions
      customer1 = create(:customer)
      invoice1 = create(:invoice, customer_id: customer1.id, merchant_id: merchant.id)
      invoice2 = create(:invoice, customer_id: customer1.id, merchant_id: merchant.id)
      invoice3 = create(:invoice, customer_id: customer1.id, merchant_id: merchant.id)
      transaction1 = create(:transaction, invoice_id: invoice1.id)
      transaction2 = create(:transaction, invoice_id: invoice2.id)
      transaction3 = create(:transaction, invoice_id: invoice3.id)
      # 2 success transactions
      customer2 = create(:customer)
      invoice4 = create(:invoice, customer_id: customer2.id, merchant_id: merchant.id)
      invoice5 = create(:invoice, customer_id: customer2.id, merchant_id: merchant.id)
      transaction4 = create(:transaction, invoice_id: invoice4.id)
      transaction5 = create(:transaction, invoice_id: invoice5.id)
      # 1 success transactions
      customer3 = create(:customer)
      invoice6 = create(:invoice, customer_id: customer3.id, merchant_id: merchant.id)
      transaction6 = create(:transaction, invoice_id: invoice6.id)

      get :show, params: {merchant_id: merchant.id, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(customer1.id)
    end
  end
end
