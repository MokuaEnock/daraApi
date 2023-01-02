class PaymentsController < ApplicationController
  def index
    render json: Payment.all
  end

  def create
    pay = Payment.create(pay_params)
    render json: pay
  end

  private

  def pay_params
    permit.params(:phone, :total)
  end
end
