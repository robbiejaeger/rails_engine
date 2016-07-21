require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :controller do
  render_views

  describe "find a collection of customers" do
    it 'returns a single customer if only one exists' do
      customer = create(:customer)

      get :index, params: {id: customer.id, format: :json}
      result_array = JSON.parse(response.body)
      expect(1).to eq(result_array.length)
      result = result_array[0]

      expect(result["id"]).to eq(customer.id)
      expect(result["first_name"]).to eq(customer.first_name)
      expect(result["last_name"]).to eq(customer.last_name)
      expect(result["created_at"]).to eq(nil)
      expect(result["updated_at"]).to eq(nil)
    end

    it 'returns multiple customers when more than one exists' do
      customers = create_list(:customer, 3)

      get :index, params: {format: :json}
      result_array = JSON.parse(response.body)
      expect(3).to eq(result_array.length)

      result_array.each_with_index do |result, n|
        expect(result["first_name"]).to eq(customers[n].first_name)
        expect(result["last_name"]).to eq(customers[n].last_name)
        expect(result["created_at"]).to eq(nil)
        expect(result["updated_at"]).to eq(nil)
      end
    end
    describe "find a specific customer" do
      it 'finds a customer when one exists' do
        customer = create(:customer)
        get :show, params: {id: customer.id, format: :json}
        result = JSON.parse(response.body)

        expect(result["id"]).to eq(customer.id)
        expect(result["first_name"]).to eq(customer.first_name)
        expect(result["last_name"]).to eq(customer.last_name)
        expect(result["created_at"]).to eq(nil)
        expect(result["updated_at"]).to eq(nil)
      end

      it 'finds a customer when several exist' do
        customer = create_list(:customer, 3)
        get :show, params: {id: customer[0].id, format: :json}
        result = JSON.parse(response.body)

        expect(result["id"]).to eq(customer[0].id)
        expect(result["first_name"]).to eq(customer[0].first_name)
        expect(result["last_name"]).to eq(customer[0].last_name)
        expect(result["created_at"]).to eq(nil)
        expect(result["updated_at"]).to eq(nil)
      end
    end
  end
end
