class Api::V1::Items::FindController < ApplicationController

  def show
    @item = Item.case_insensitive_find_by(item_params)
  end

  def index
    @items = Item.case_insensitive_where(item_params)
  end

  private

  def item_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
