require 'rails_helper'

RSpec.describe Api::V1::Customers::FindController, type: :controller do
  render_views

  describe "returns all customers" do
    it 'returns list of all customers with same last name' do
      customers = create_list(:customer, 3, last_name: "TEST")

      get :index, params: {last_name: "TEST", format: :json}
      result = JSON.parse(response.body)

      expect(result.count).to eq(3)
      expect(result[0]["id"]).to eq(customers[0].id)
      expect(result[0]["first_name"]).to eq(customers[0].first_name)
      expect(result[0]["last_name"]).to eq(customers[0].last_name)
    end
  end

  describe "find a customer when multiple customers exist" do
    it 'finds customer by id' do
      customers = create_list(:customer, 3)

      get :show, params: {id: customers[0].id, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(customers[0].id)
      expect(result["first_name"]).to eq(customers[0].first_name)
      expect(result["last_name"]).to eq(customers[0].last_name)
    end

    it 'finds customer by first name' do
      customers = create_list(:customer, 3)

      get :show, params: {first_name: customers[0].first_name, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(customers[0].id)
      expect(result["first_name"]).to eq(customers[0].first_name)
      expect(result["last_name"]).to eq(customers[0].last_name)
    end

    it 'finds customer by last name' do
      customers = create_list(:customer, 3)

      get :show, params: {last_name: customers[0].last_name, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(customers[0].id)
      expect(result["first_name"]).to eq(customers[0].first_name)
      expect(result["last_name"]).to eq(customers[0].last_name)
    end
  end
end
