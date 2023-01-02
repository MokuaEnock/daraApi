class PaymentsController < ApplicationController
  skip_before_action :authorized, only: %i[create index]

  def index
    render json: Payment.all
  end

  def create
    pay = Payment.create(pay_params)
    render json: pay
  end

  private

  def pay_params
    params.permit(:phone, :total)
  end
end
