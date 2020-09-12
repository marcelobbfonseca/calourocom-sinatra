require 'byebug' unless ENV['APP_ENV'].eql? 'production'
require 'sinatra/json'
require 'jwt'


class JWTAuthorization 

    def initialize app
      @app = app
    end
    
    def call env
      return @app.call env if ENV['APP_ENV'].eql? "test"
  
      begin
        # env.fetch gets http header
        #bearer = env.fetch('HTTP_AUTHORIZATION', '').split(' ')[1]
        bearer = env.fetch('HTTP_AUTHORIZATION').slice(7..-1)
        # key = OpenSSL::PKey::RSA.new File.read '../rsa_2048_pub.pem'
        key = OpenSSL::PKey::RSA.new ENV['PUBLIC_KEY']
        payload = JWT.decode bearer, key, true, { algorithm: 'RS256'}
        claims = payload.first # email, 
        
        if claims['iss'] == 'user'
          user = User.find_by_email(claims['email'])
          user = User.create({email: claims['email']}) if user.nil?
          env[:user] = user
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
      rescue Pundit::NotAuthorizedError
        [401, { 'Content-Type' => 'text/plain' }, ['Unauthorized access.']]
      end
    end
    
  end