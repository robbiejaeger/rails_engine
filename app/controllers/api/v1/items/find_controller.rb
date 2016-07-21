class Api::V1::Items::FindController < ApplicationController

  def show
    @item = Item.custom_find_by(query_params)
  end

  def index
    @items = Item.custom_where(query_params)
  end
end
