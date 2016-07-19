class Api::V1::InvoiceItems::RandomController < ApplicationController
  respond_to :json, :xml

  def show
    respond_with InvoiceItem.limit(1).order("RANDOM()")
  end

end
