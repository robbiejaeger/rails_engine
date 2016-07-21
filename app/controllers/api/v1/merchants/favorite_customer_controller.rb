class Api::V1::Merchants::FavoriteCustomerController < ApplicationController

  def show
    @id = Merchant.find_by(id: params[:merchant_id]).favorite_customer_id
  end
end
