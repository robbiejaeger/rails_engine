class Api::V1::Merchants::MostItemsController < ApplicationController

  def index
    @merchants = Merchant.most_items_sold(params[:quantity])
  end
end
