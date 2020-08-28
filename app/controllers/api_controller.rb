# frozen_string_literal: true

class ApiController < ApplicationController
  protect_from_forgery with: :exception
  before_action :get_token

  def get_token
    find_user = User.where(token: params[:token])
    warden.authenticate!(:token)
    render json: { danger: 'Token invalido!' } unless find_user.present?
  end
end
