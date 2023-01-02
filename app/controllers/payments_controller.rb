require "uri"
require "net/http"
require "base64"

class PaymentsController < ApplicationController
  skip_before_action :authorized, only: %i[create index]

  def index
    render json: Payment.all
  end

  def create
    pay = Payment.create(pay_params)
    render json: pay
  end

  def mpesa_index
    token = get_access_token

    url = URI("https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Authorization"] = "Bearer #{token}"
    request["Content-Type"] = "application/json"
    password =
      Base64.strict_encode64(
        "174379bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919#{Time.now.strftime "%Y%m%d%H%M%S"}"
      )

    request.body = {
      BusinessShortCode: 174_379,
      Password: password,
      Timestamp: "#{Time.now.strftime "%Y%m%d%H%M%S"}",
      TransactionType: "CustomerPayBillOnline",
      Amount: 100,
      PartyA: params[:phone],
      PartyB: 174_379,
      PhoneNumber: params[:phone],
      CallBackURL: "https://1bd8-102-215-78-19.in.ngrok.io/mpesa_callback",
      AccountReference: "Hired LTD",
      TransactionDesc: "Payment of subscription"
    }.to_json

    response = https.request(request)
    render json: response.body
  end

  def mpesa_callback
    render json: params[:Body].to_json
  end

  private

  def pay_params
    params.permit(:phone, :total)
  end

  def get_access_token
    url =
      URI(
        "https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials"
      )

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    enc =
      Base64.strict_encode64(
        "GQURzRWARSNHgtjnzs2JbbnYn4XdA2Cz:pavEGKI5l8G7KUrY"
      )
    request["Authorization"] = "Basic #{enc}"
    response = https.request(request)

    data = JSON.parse(response.body)
    data["access_token"]
  end

  def sample_token
    ​
    url =
      URI(
        "https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials"
      )
    ​
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    ​
    request = Net::HTTP::Post.new(url)
    request[
      "Authorization"
    ] = "Bearer cFJZcjZ6anEwaThMMXp6d1FETUxwWkIzeVBDa2hNc2M6UmYyMkJmWm9nMHFRR2xWOQ=="
    ​
    response = https.request(request)
    data = JSON.parse(response.body)
    return data["access_token"]
  end
end
