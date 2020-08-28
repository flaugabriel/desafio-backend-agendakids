class ApiTokenStrategy < Warden::Strategies::Base
  def valid?
    token.present?
  end

  def authenticate!
    byebug
    user = User.find_by(token: token)

    if user
      success!(user)
    else
      fail!('Email ou senha Ivalida')
    end
  end

  private

  def token
    env['HTTP_AUTHORIZATION'].to_s.remove('Bearer ')
  end
end