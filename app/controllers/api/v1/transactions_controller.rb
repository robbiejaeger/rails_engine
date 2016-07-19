class Api::V1::TransactionsController < ApplicationController

  def index
    @transaction = Transaction.all
  end

  def show
    @transactions = Transaction.find(params[:id])
  end
end
