require 'rails_helper'

RSpec.describe Api::V1::Items::MerchantsController, type: :controller do
  render_views

  describe "returns item for an invoice item" do
    it 'returns item' do
      item = create(:item)

      get :show, params: {item_id: item.id, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(item.merchant.id)
    end
  end
end
