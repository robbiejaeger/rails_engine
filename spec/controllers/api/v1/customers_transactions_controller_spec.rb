require 'rails_helper'

RSpec.describe Api::V1::Customers::TransactionsController, type: :controller do
  render_views

  describe "find a collection of transactions scoped to a customer" do
    it 'returns a single transaction if only one exists' do
      customer = create(:customer)
      invoice = create(:invoice, customer_id: customer.id)
      transaction = create(:transaction, invoice_id: invoice.id)
      get :index, params: {customer_id: customer.id, format: :json}

      result_array = JSON.parse(response.body)
      expect(1).to eq(result_array.length)
      result = result_array[0]

      expect(result["id"]).to eq(transaction.id)
      expect(result["invoice_id"]).to eq(transaction.invoice_id)
      expect(result["credit_card_number"]).to eq(transaction.credit_card_number)
      expect(result["result"]).to eq(transaction.result)
      expect(result["created_at"]).to eq(nil)
      expect(result["updated_at"]).to eq(nil)
    end

    it 'returns a single transactions scoped to the given customer out of many' do
      customer1 = create(:customer)
      customer2 = create(:customer)
      invoice1 = create(:invoice, customer_id: customer1.id)
      invoice2 = create(:invoice, customer_id: customer2.id)
      transaction = create(:transaction, invoice_id: invoice1.id)
      transactions = create_list(:transaction, 2, invoice_id: invoice2.id)


      get :index, params: {customer_id: customer1.id, format: :json}
      result_array = JSON.parse(response.body)
      expect(1).to eq(result_array.length)
      result = result_array[0]

      expect(result["id"]).to eq(transaction.id)
      expect(result["invoice_id"]).to eq(transaction.invoice_id)
      expect(result["credit_card_number"]).to eq(transaction.credit_card_number)
      expect(result["result"]).to eq(transaction.result)
      expect(result["created_at"]).to eq(nil)
      expect(result["updated_at"]).to eq(nil)
    end

    it 'returns multiple transactions, but only those scoped to the given customer' do
      customer1 = create(:customer)
      customer2 = create(:customer)
      invoice1 = create(:invoice, customer_id: customer1.id)
      invoice2 = create(:invoice, customer_id: customer2.id)
      transactions = create_list(:transaction, 3, invoice_id: invoice1.id)
      transactions = transactions + create_list(:transaction, 2, invoice_id: invoice2.id)


      get :index, params: {customer_id: customer1.id, format: :json}
      result_array = JSON.parse(response.body)
      expect(3).to eq(result_array.length)

      result_array.each_with_index do |result, n|
        expect(result["id"]).to eq(transactions[n].id)
        expect(result["invoice_id"]).to eq(transactions[n].invoice_id)
        expect(result["credit_card_number"]).to eq(transactions[n].credit_card_number)
        expect(result["result"]).to eq(transactions[n].result)
        expect(result["created_at"]).to eq(nil)
        expect(result["updated_at"]).to eq(nil)
      end
    end
  end
end
