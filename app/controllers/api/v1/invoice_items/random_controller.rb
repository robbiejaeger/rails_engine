class Api::V1::InvoiceItems::RandomController < ApplicationController

  def show
    render json: InvoiceItem.limit(1).order("RANDOM()")
  end
end
