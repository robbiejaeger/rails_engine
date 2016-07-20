require 'rails_helper'

RSpec.describe Api::V1::Invoices::FindController, type: :controller do
  render_views

  describe "find a collection of invoices when multiple invoices exist" do
    it 'returns a single invoice if only one matches. Search by id' do
      invoices = create_list(:invoice, 3)

      get :index, params: {id: invoices[0].id, format: :json}
      result_array = JSON.parse(response.body)
      expect(1).to eq(result_array.length)
      result = result_array[0]

      expect(result["id"]).to eq(invoices[0].id)
      expect(result["status"]).to eq(invoices[0].status)
      expect(result["customer_id"]).to eq(invoices[0].customer_id)
      expect(result["merchant_id"]).to eq(invoices[0].merchant_id)
      expect(result["id"]).not_to eq(invoices[1].id)
      expect(result["created_at"]).to eq(nil)
      expect(result["updated_at"]).to eq(nil)
    end

    it 'returns multiple invoices searching by status' do
      invoices = create_list(:invoice, 3)
      invoices = invoices + create_list(:invoice, 3, status: "pending")

      get :index, params: {status: "pending", format: :json}
      result_array = JSON.parse(response.body)
      expect(3).to eq(result_array.length)

      result_array.each_with_index do |result, n|
        expect(result["status"]).to eq("pending")
        expect(result["customer_id"]).to eq(invoices[n+3].customer_id)
        expect(result["merchant_id"]).to eq(invoices[n+3].merchant_id)
        expect(result["created_at"]).to eq(nil)
        expect(result["updated_at"]).to eq(nil)
      end
    end

    it 'returns multiple invoices searching by customer_id' do
      invoices = create_list(:invoice, 3)
      customer = create(:customer)
      invoices = invoices + create_list(:invoice, 3, customer_id: customer.id)

      get :index, params: {customer_id: customer.id, format: :json}
      result_array = JSON.parse(response.body)
      expect(3).to eq(result_array.length)

      result_array.each_with_index do |result, n|
        expect(result["status"]).to eq(invoices[n+3].status)
        expect(result["customer_id"]).to eq(customer.id)
        expect(result["merchant_id"]).to eq(invoices[n+3].merchant_id)
        expect(result["created_at"]).to eq(nil)
        expect(result["updated_at"]).to eq(nil)
      end
    end

    it 'returns multiple invoices searching by merchant_id' do
      invoices = create_list(:invoice, 3)
      merchant = create(:merchant)
      invoices = invoices + create_list(:invoice, 3, merchant_id: merchant.id)

      get :index, params: {merchant_id: merchant.id, format: :json}
      result_array = JSON.parse(response.body)
      expect(3).to eq(result_array.length)

      result_array.each_with_index do |result, n|
        expect(result["status"]).to eq(invoices[n+3].status)
        expect(result["customer_id"]).to eq(invoices[n+3].customer_id)
        expect(result["merchant_id"]).to eq(merchant.id)
        expect(result["created_at"]).to eq(nil)
        expect(result["updated_at"]).to eq(nil)
      end
    end
  end
end
