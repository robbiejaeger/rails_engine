class Api::V1::Merchants::FindController < ApplicationController

  def index
    @merchants = Merchant.custom_where(merchant_params)
  end

  def show
    @merchant = Merchant.custom_find_by(merchant_params)
  end

  private

  def merchant_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end
