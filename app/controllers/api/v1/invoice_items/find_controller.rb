class Api::V1::InvoiceItems::FindController < ApplicationController
  respond_to :json, :xml

  def show
    respond_with InvoiceItem.find_by( strong_params )
  end

  def index
    respond_with InvoiceItem.where( strong_params )
  end


  private
  def strong_params
    params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
  end
end
