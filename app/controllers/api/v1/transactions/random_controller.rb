class Api::V1::Transactions::RandomController < ApplicationController

  def show
    @transaction = Transaction.limit(1).order("RANDOM()")[0]
  end
end
