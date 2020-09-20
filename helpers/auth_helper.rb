require 'jwt'

module AuthHelper

    def protected!
        begin
          bearer = request.env.fetch('HTTP_AUTHORIZATION').slice(7..-1)
          key = OpenSSL::PKey::RSA.new ENV['PUBLIC_KEY']
          payload = JWT.decode bearer, key, true, { algorithm: 'RS256'}
          claims = payload.first # email, 
          if claims['iss'] == 'user'
            user = User.find_by_email(claims['email'])
            user = User.create({email: claims['email'], role: :user}) if user.nil?
            request.env[:user] = user
          end
    
        rescue JWT::ExpiredSignature 
          halt 403,{ 'Content-Type' => 'application/json' }, 'The token has expired.'
        rescue JWT::DecodeError
          halt 401,{ 'Content-Type' => 'application/json' }, 'A token must be passed.'
        rescue JWT::InvalidIssuerError
          halt 403,{ 'Content-Type' => 'application/json' }, 'The token does not have a valid issuer.'
        rescue JWT::InvalidIatError
          halt 403,{ 'Content-Type' => 'application/json' }, 'The token does not have a valid "issued at" time.'
        rescue Pundit::NotAuthorizedError
          halt 401,{ 'Content-Type' => 'application/json' }, 'Unauthorized access.'

        end
    end
end