class Api::V1::Items::FindController < ApplicationController

  def show
    @item = Item.find_by(item_params)
    render "show.json.jbuilder"
    # byebug
  end

  def index
    @items = Item.where(item_params)
  end

  private

  def item_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
