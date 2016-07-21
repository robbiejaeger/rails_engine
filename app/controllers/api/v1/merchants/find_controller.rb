class Api::V1::Merchants::FindController < ApplicationController

  def index
    @merchants = Merchant.custom_where(query_params)
  end

  def show
    @merchant = Merchant.custom_find_by(query_params)
  end
end
