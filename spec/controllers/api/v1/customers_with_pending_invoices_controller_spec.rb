require 'rails_helper'

RSpec.describe Api::V1::Merchants::CustomersWithPendingInvoicesController, type: :controller do
  render_views

  describe "find a customer when only one customer exists" do
    it 'returns single customer when only one exists' do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id, status: 'pending')

      get :index, params: {merchant_id: merchant.id, format: :json}
      result_array = JSON.parse(response.body)
      expect(1).to eq(result_array.length)
      result = result_array[0]

      expect(result["id"]).to eq(customer.id)
      expect(result["first_name"]).to eq(customer.first_name)
      expect(result["last_name"]).to eq(customer.last_name)
    end
  end

  describe "find a customer when multiple customers exist" do
    it 'finds a single customer with a single invoice' do
      customers = create_list(:customer, 3)
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id, status: 'pending')

      get :index, params: {merchant_id: merchant.id, format: :json}
      result_array = JSON.parse(response.body)
      expect(1).to eq(result_array.length)
      result = result_array[0]

      expect(result["id"]).to eq(customer.id)
      expect(result["first_name"]).to eq(customer.first_name)
      expect(result["last_name"]).to eq(customer.last_name)
    end

    it 'finds a single customer with multiple invoices' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      customer1 = create(:customer)
      customer2 = create(:customer)
      invoices = create_list(:invoice, 3, customer_id: customer1.id, merchant_id: merchant1.id, status: 'pending')
      invoices += create_list(:invoice, 3, customer_id: customer2.id, merchant_id: merchant2.id, status: 'pending')

      get :index, params: {merchant_id: merchant1.id, format: :json}
      result_array = JSON.parse(response.body)
      expect(1).to eq(result_array.length)
      result = result_array[0]

      expect(result["id"]).to eq(customer1.id)
      expect(result["first_name"]).to eq(customer1.first_name)
      expect(result["last_name"]).to eq(customer1.last_name)
    end

    it 'finds multiple customers with multiple invoices' do
      merchant1 = create(:merchant)

      customer1 = create(:customer)
      customer2 = create(:customer)
      customer3 = create(:customer)

      invoices = create_list(:invoice, 3, customer_id: customer1.id, merchant_id: merchant1.id, status: 'pending')
      invoices += create_list(:invoice, 3, customer_id: customer2.id, merchant_id: merchant1.id, status: 'pending')
      invoices += create_list(:invoice, 3, customer_id: customer3.id, merchant_id: merchant1.id)

      get :index, params: {merchant_id: merchant1.id, format: :json}
      result_array = JSON.parse(response.body)
      expect(2).to eq(result_array.length)

      expect(result_array[0]["id"]).to eq(customer1.id)
      expect(result_array[0]["first_name"]).to eq(customer1.first_name)
      expect(result_array[0]["last_name"]).to eq(customer1.last_name)
      expect(result_array[1]["id"]).to eq(customer2.id)
      expect(result_array[1]["first_name"]).to eq(customer2.first_name)
      expect(result_array[1]["last_name"]).to eq(customer2.last_name)
    end


    it 'finds customers for different merchants' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)

      customer1 = create(:customer)
      customer2 = create(:customer)
      customer3 = create(:customer)
      customer4 = create(:customer)

      invoices = create_list(:invoice, 3, customer_id: customer1.id, merchant_id: merchant1.id, status: 'pending')
      invoices += create_list(:invoice, 3, customer_id: customer2.id, merchant_id: merchant1.id, status: 'pending')
      invoices += create_list(:invoice, 3, customer_id: customer3.id, merchant_id: merchant1.id)
      invoices += create_list(:invoice, 3, customer_id: customer3.id, merchant_id: merchant2.id, status: 'pending')
      invoices += create_list(:invoice, 3, customer_id: customer4.id, merchant_id: merchant2.id)

      get :index, params: {merchant_id: merchant1.id, format: :json}
      result_array = JSON.parse(response.body)
      expect(2).to eq(result_array.length)

      expect(result_array[0]["id"]).to eq(customer1.id)
      expect(result_array[0]["first_name"]).to eq(customer1.first_name)
      expect(result_array[0]["last_name"]).to eq(customer1.last_name)
      expect(result_array[1]["id"]).to eq(customer2.id)
      expect(result_array[1]["first_name"]).to eq(customer2.first_name)
      expect(result_array[1]["last_name"]).to eq(customer2.last_name)

      #test for another merchant after the first
      get :index, params: {merchant_id: merchant2.id, format: :json}
      result_array = JSON.parse(response.body)
      expect(1).to eq(result_array.length)
      result = result_array[0]

      expect(result["id"]).to eq(customer3.id)
      expect(result["first_name"]).to eq(customer3.first_name)
      expect(result["last_name"]).to eq(customer3.last_name)
    end
  end
end
