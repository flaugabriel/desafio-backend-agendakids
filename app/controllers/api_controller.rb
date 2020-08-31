# frozen_string_literal: true

class ApiController < ApplicationController
  before_action :token

  rescue_from CanCan::AccessDenied do |_exception|
    render json: { danger: 'Acesso negado. Você não está autorizado a acessar essa página' }
  end

  def token
    find_user = User.where(token: request.headers['Authorization'])
    if find_user.present?
      warden.authenticate!(:token)
    else
      render json: { danger: 'Token invalido!' }
    end
  end
end
