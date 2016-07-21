class Api::V1::Transactions::FindController < ApplicationController

  def index
    @transactions = Transaction.custom_where(query_params)
  end

  def show
    @transaction = Transaction.custom_find_by(query_params)
  end
end
