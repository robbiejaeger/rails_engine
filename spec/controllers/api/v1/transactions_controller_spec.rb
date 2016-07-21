require 'rails_helper'

RSpec.describe Api::V1::TransactionsController, type: :controller do
  render_views

  describe "find a collection of transactions" do
    it 'returns a single transaction if only one exists' do
      transaction = create(:transaction)

      get :index, params: {id: transaction.id, format: :json}
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

    it 'returns multiple transactions when more than one exists' do
      transactions = create_list(:transaction, 3)

      get :index, params: {format: :json}
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

    describe "find a specific transaction" do
      it 'finds a transaction when one exists' do
        transaction = create(:transaction)
        get :show, params: {id: transaction.id, format: :json}
        result = JSON.parse(response.body)

        expect(result["id"]).to eq(transaction.id)
        expect(result["invoice_id"]).to eq(transaction.invoice_id)
        expect(result["credit_card_number"]).to eq(transaction.credit_card_number)
        expect(result["result"]).to eq(transaction.result)
        expect(result["created_at"]).to eq(nil)
        expect(result["updated_at"]).to eq(nil)
      end

      it 'finds a transaction when several exist' do
        transaction = create_list(:transaction, 3)
        get :show, params: {id: transaction[0].id, format: :json}
        result = JSON.parse(response.body)

        expect(result["id"]).to eq(transaction[0].id)
        expect(result["invoice_id"]).to eq(transaction[0].invoice_id)
        expect(result["credit_card_number"]).to eq(transaction[0].credit_card_number)
        expect(result["result"]).to eq(transaction[0].result)
        expect(result["created_at"]).to eq(nil)
        expect(result["updated_at"]).to eq(nil)
      end
    end
  end
end
