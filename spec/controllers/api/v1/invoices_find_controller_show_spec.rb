require 'rails_helper'

RSpec.describe Api::V1::Invoices::FindController, type: :controller do
  render_views

  describe "find a single invoice when multiple invoices exist" do
    it 'finds an invoice by id' do
      invoices = create_list(:invoice, 3)

      get :show, params: {id: invoices[0].id, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(invoices[0].id)
      expect(result["customer_id"]).to eq(invoices[0].customer_id)
      expect(result["merchant_id"]).to eq(invoices[0].merchant_id)
      expect(result["status"]).to eq(invoices[0].status)
      expect(result["created_at"]).to eq(nil)
      expect(result["updated_at"]).to eq(nil)
    end

    it 'finds an invoice by status' do
      invoices = create_list(:invoice, 2)
      invoices << create(:invoice, status: "pending")

      get :show, params: {status: invoices[2].status, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(invoices[2].id)
      expect(result["customer_id"]).to eq(invoices[2].customer_id)
      expect(result["merchant_id"]).to eq(invoices[2].merchant_id)
      expect(result["status"]).to eq(invoices[2].status)
      expect(result["created_at"]).to eq(nil)
      expect(result["updated_at"]).to eq(nil)
    end

    it 'finds an invoice by customer_id' do
      invoices = create_list(:invoice, 2)
      customer = create(:customer)
      invoices << create(:invoice, customer_id: customer.id)

      get :show, params: {customer_id: customer.id, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(invoices[2].id)
      expect(result["customer_id"]).to eq(invoices[2].customer_id)
      expect(result["merchant_id"]).to eq(invoices[2].merchant_id)
      expect(result["status"]).to eq(invoices[2].status)
      expect(result["created_at"]).to eq(nil)
      expect(result["updated_at"]).to eq(nil)
    end

    it 'finds an invoice by merchant_id' do
      invoices = create_list(:invoice, 2)
      merchant = create(:merchant)
      invoices << create(:invoice, merchant_id: merchant.id)

      get :show, params: {merchant_id: merchant.id, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(invoices[2].id)
      expect(result["customer_id"]).to eq(invoices[2].customer_id)
      expect(result["merchant_id"]).to eq(invoices[2].merchant_id)
      expect(result["status"]).to eq(invoices[2].status)
      expect(result["created_at"]).to eq(nil)
      expect(result["updated_at"]).to eq(nil)
    end
  end
end
