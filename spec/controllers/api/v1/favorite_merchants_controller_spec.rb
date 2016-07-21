require 'rails_helper'

RSpec.describe Api::V1::Customers::FavoriteMerchantsController, type: :controller do
  render_views

  describe "find a merchant when only one merchant exists" do
    it 'returns single merchant when only one exists' do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      transaction = create(:transaction, invoice_id: invoice.id)

      get :show, params: {customer_id: customer.id, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(merchant.id)
    end
    
    it 'returns one of multiple merchants' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)
      # 3 success transactions
      customer = create(:customer)
      invoice1 = create(:invoice, customer_id: customer.id, merchant_id: merchant1.id)
      invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant1.id)
      invoice3 = create(:invoice, customer_id: customer.id, merchant_id: merchant1.id)
      transaction1 = create(:transaction, invoice_id: invoice1.id)
      transaction2 = create(:transaction, invoice_id: invoice2.id)
      transaction3 = create(:transaction, invoice_id: invoice3.id)
      # 2 success transactions
      invoice4 = create(:invoice, customer_id: customer.id, merchant_id: merchant2.id)
      invoice5 = create(:invoice, customer_id: customer.id, merchant_id: merchant2.id)
      transaction4 = create(:transaction, invoice_id: invoice4.id)
      transaction5 = create(:transaction, invoice_id: invoice5.id)
      # 1 success transactions
      invoice6 = create(:invoice, customer_id: customer.id, merchant_id: merchant3.id)
      transaction6 = create(:transaction, invoice_id: invoice6.id)

      get :show, params: {customer_id: customer.id, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(merchant1.id)
    end
  end
end
