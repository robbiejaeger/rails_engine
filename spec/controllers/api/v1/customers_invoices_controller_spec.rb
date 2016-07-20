require 'rails_helper'

RSpec.describe Api::V1::Customers::InvoicesController, type: :controller do
  render_views

  describe "find a collection of invoices scoped to a customer" do
    it 'returns a single invoice if only one exists' do
      customer = create(:customer)
      invoice = create(:invoice, customer_id: customer.id)

      get :index, params: {customer_id: customer.id, format: :json}

      result_array = JSON.parse(response.body)
      expect(1).to eq(result_array.length)
      result = result_array[0]

      expect(result["id"]).to eq(invoice.id)
      expect(result["customer_id"]).to eq(invoice.customer_id)
      expect(result["merchant_id"]).to eq(invoice.merchant_id)
      expect(result["status"]).to eq(invoice.status)
      expect(result["created_at"]).to eq(nil)
      expect(result["updated_at"]).to eq(nil)
    end

    it 'returns a single invoices scoped to the given customer out of many' do
      customer1 = create(:customer)
      customer2 = create(:customer)
      invoice1 = create(:invoice, customer_id: customer1.id)
      invoices = create_list(:invoice, 2, customer_id: customer2.id)


      get :index, params: {customer_id: customer1.id, format: :json}
      result_array = JSON.parse(response.body)
      expect(1).to eq(result_array.length)
      result = result_array[0]

      expect(result["id"]).to eq(invoice1.id)
      expect(result["status"]).to eq(invoice1.status)
      expect(result["merchant_id"]).to eq(invoice1.merchant_id)
      expect(result["customer_id"]).to eq(customer1.id)
      expect(result["created_at"]).to eq(nil)
      expect(result["updated_at"]).to eq(nil)
    end

    it 'returns multiple invoices, but only those scoped to the given customer' do
      customer1 = create(:customer)
      customer2 = create(:customer)
      invoices = create_list(:invoice, 3, customer_id: customer1.id)
      invoices = invoices + create_list(:invoice, 2, customer_id: customer2.id)


      get :index, params: {customer_id: customer1.id, format: :json}
      result_array = JSON.parse(response.body)
      expect(3).to eq(result_array.length)

      result_array.each_with_index do |result, n|
        expect(result["id"]).to eq(invoices[n].id)
        expect(result["status"]).to eq(invoices[n].status)
        expect(result["merchant_id"]).to eq(invoices[n].merchant_id)
        expect(result["customer_id"]).to eq(customer1.id)
        expect(result["created_at"]).to eq(nil)
        expect(result["updated_at"]).to eq(nil)
      end
    end
  end
end
