class ApplicationController < ActionController::API
  def encode_token(payload)
    JWT.encode(payload, "my_s3cr3t")
  end

  def auth_header

  end

  def decode_token(token)
    JWT.decode(token, "my_s3cr3t"[0])
  end
end
