require 'byebug'
require 'jwt'

class JWTAuthorization

    def initialize app
      @app = app
    end
  
    def call env
        
      begin
        # env.fetch gets http header
        #bearer = env.fetch('HTTP_AUTHORIZATION', '').split(' ')[1]
        bearer = env.fetch('HTTP_AUTHORIZATION').slice(7..-1)
        key = OpenSSL::PKey::RSA.new File.read '../rsa_2048_pub.pem'
        payload = JWT.decode bearer, key, true, { algorithm: 'RS256'}
        byebug 
        claims = payload.first # email, 
        
        if claims['iss'].elq? 'user'
          env[:user] = User.find_by_email(claims['email'])
        end
  
        @app.call env
      rescue JWT::DecodeError
        [401, { 'Content-Type' => 'text/plain' }, ['A token must be passed.']]
      rescue JWT::ExpiredSignature
        [403, { 'Content-Type' => 'text/plain' }, ['The token has expired.']]
      rescue JWT::InvalidIssuerError
        [403, { 'Content-Type' => 'text/plain' }, ['The token does not have a valid issuer.']]
      rescue JWT::InvalidIatError
        [403, { 'Content-Type' => 'text/plain' }, ['The token does not have a valid "issued at" time.']]
      end
    end
  
  end