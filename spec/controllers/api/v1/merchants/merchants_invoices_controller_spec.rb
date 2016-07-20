require 'rails_helper'

RSpec.describe Api::V1::Invoices::FindController, type: :controller do
  render_views

  describe "find a collection of invoices scoped to a merchant" do
    it 'returns a single invoice if only one exists' do
      merchant = create(:merchant)
      invoice = create(:invoice, merchant_id: merchant.id)

      get :index, params: {merchant_id: merchant.id, format: :json}
      result_array = JSON.parse(response.body)
      expect(1).to eq(result_array.length)
      result = result_array[0]

      expect(result["id"]).to eq(invoice.id)
      expect(result["status"]).to eq(invoice.status)
      expect(result["customer_id"]).to eq(invoice.customer_id)
      expect(result["merchant_id"]).to eq(invoice.merchant_id)
      expect(result["created_at"]).to eq(nil)
      expect(result["updated_at"]).to eq(nil)
    end

    it 'returns multiple invoices, but only those for a given merchant' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      invoices = create_list(:invoice, 3, merchant_id: merchant1.id)
      invoices = invoices + create_list(:invoice, 2, merchant_id: merchant2.id)

      get :index, params: {merchant_id: merchant1.id, format: :json}

      result_array = JSON.parse(response.body)
      expect(3).to eq(result_array.length)

      result_array.each_with_index do |result, n|
        expect(result["id"]).to eq(invoices[n].id)
        expect(result["status"]).to eq(invoices[n].status)
        expect(result["customer_id"]).to eq(invoices[n].customer_id)
        expect(result["merchant_id"]).to eq(merchant1.id)
        expect(result["created_at"]).to eq(nil)
        expect(result["updated_at"]).to eq(nil)
      end
    end
  end
end
