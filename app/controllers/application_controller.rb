class ApplicationController < ActionController::API
  def encode_token(payload)
    JWT.encode(payload, "secret")
  end

  def decode_token
    #Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiMSJ9.QDFVlCkbb6iQ5Pm36C2h9XW1Z90qB3yyhxZakAmcYOg'
    auth_header = request.headers['Authorization']
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, "secret", true, algorithm: "HS256")
      rescue JWT::DecodeError
        nil
      end
    end
  end
  def authorized_user
    decoded_token = decode_token()
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end
  def authorize 
    render json: {message: "You have to login first "}, status: :unauthorized unless authorized_user
      
    end

end
