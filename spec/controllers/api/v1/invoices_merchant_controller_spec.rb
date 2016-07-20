require 'rails_helper'

RSpec.describe Api::V1::Invoices::MerchantsController, type: :controller do
  render_views

  describe "returns merchant for an invoice" do
    it 'returns merchant' do
      invoice_1 = create(:invoice)

      get :show, params: {invoice_id: invoice_1.id, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(invoice_1.merchant.id)
    end
  end
end
