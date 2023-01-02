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
end
