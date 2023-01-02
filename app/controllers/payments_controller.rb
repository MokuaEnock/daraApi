class PaymentsController < ApplicationController
  def index
    render json: Payment.all
  end

  def create
    pay = Payment.create(pay_params)
    render json: pay
  end
end
