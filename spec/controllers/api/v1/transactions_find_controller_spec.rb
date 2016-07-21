require 'rails_helper'

RSpec.describe Api::V1::Transactions::FindController, type: :controller do
  render_views

  describe "returns all transactions" do
    it 'returns list of all transactions with same result' do
      transactions = create_list(:transaction, 3, result: "success")
      transaction_odd = create(:transaction, result: "failure")

      get :index, params: {result: "success", format: :json}
      result = JSON.parse(response.body)

      expect(result.count).to eq(3)
      expect(result[0]["id"]).to eq(transactions[0].id)
      expect(result[0]["credit_card_number"]).to eq(transactions[0].credit_card_number)
      expect(result[0]["result"]).to eq(transactions[0].result)
    end
  end

  describe "find a transaction when multiple transactions exist" do
    it 'finds transaction by id' do
      transactions = create_list(:transaction, 3)

      get :show, params: {id: transactions[0].id, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(transactions[0].id)
      expect(result["credit_card_number"]).to eq(transactions[0].credit_card_number)
      expect(result["result"]).to eq(transactions[0].result)
    end

    it 'finds merchant by credit_card_number' do
      transaction_1 = create(:transaction)
      transaction_2 = create(:transaction, credit_card_number: 2)

      get :show, params: {credit_card_number: transaction_1.credit_card_number, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(transaction_1.id)
      expect(result["credit_card_number"]).to eq(transaction_1.credit_card_number)
      expect(result["result"]).to eq(transaction_1.result)
    end
  end
end
