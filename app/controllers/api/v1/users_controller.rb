# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApiController
      load_and_authorize_resource # cancancan permissions
      skip_before_action :verify_authenticity_token
      before_action :set_user, except: %i[index edit]

      # render edit form
      def edit
        @user = current_user
        render json: @user
      end

      # update user info
      def update
        if user_params[:password].blank? || user_params[:password_confirmation].blank? # remove password if both fields are not filled
          params[:user].delete(:password)
          params[:user].delete(:password_confirmation)
        end

        if @user.update(user_params)
          bypass_sign_in(@user) # if user change password sign_in user again
          render json: { messager: 'Perfil editado com sucesso.', profile: @user  }
        else
          render json: { messager: 'Houve um erro.' }
        end
      end

      # get all non archived messages
      def index
        @users = User.normal
        render json: @users
      end

      # get all messages non archived of a user , sent and received
      def messages
        @user = User.find(params[:id])
        @sent = Message.sent_from(@user).ordered
        @received = Message.sent_to(@user).ordered
        render json: { user: @user, sent: @sent, received: @received }
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(
          :name,
          :email,
          :password,
          :password_confirmation
        )
      end
    end
  end
end
