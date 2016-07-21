class Api::V1::Items::RandomController < ApplicationController

  def show
    @item = Item.limit(1).order("RANDOM()")[0]
  end
end
