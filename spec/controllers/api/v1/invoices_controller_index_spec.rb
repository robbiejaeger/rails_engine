require 'rails_helper'

RSpec.describe Api::V1::InvoicesController, type: :controller do
  render_views

  describe "find a collection of invoices" do
    it 'returns a single invoice if only one exists' do
      invoice = create(:invoice)

      get :index, params: {id: invoice.id, format: :json}
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

    it 'returns multiple invoices when more than one exists' do
      invoices = create_list(:invoice, 3)

      get :index, params: {format: :json}
      result_array = JSON.parse(response.body)
      expect(3).to eq(result_array.length)

      result_array.each_with_index do |result, n|
        expect(result["status"]).to eq(invoices[n].status)
        expect(result["customer_id"]).to eq(invoices[n].customer_id)
        expect(result["merchant_id"]).to eq(invoices[n].merchant_id)
        expect(result["created_at"]).to eq(nil)
        expect(result["updated_at"]).to eq(nil)
      end
    end
  end
end
