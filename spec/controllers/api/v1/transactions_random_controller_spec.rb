require 'rails_helper'

RSpec.describe Api::V1::Transactions::RandomController, type: :controller do
  render_views

  describe "returns random transaction" do
    it 'returns a single transaction' do
      customers = create_list(:transaction, 3)

      get :show, params: {format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to_not be_nil
      expect(result["invoice_id"]).to_not be_nil
      expect(result["credit_card_number"]).to_not be_nil
      expect(result["result"]).to_not be_nil
    end
  end
end
