# frozen_string_literal: true

module Api
  module V1
    class MessagesController < ApiController
      load_and_authorize_resource # cancancan permissions
      skip_before_action :verify_authenticity_token
      before_action :verify_author, only: [:show]
      # render form for new message

      def new
        @message = Message.new
      end

      # creates a new message
      def create
        user = User.find_by_email(message_params[:receiver_email]) # find user by email instead of id
        @message = Message.new(message_params.merge(from: current_user.id)) # adds current_user id as sender of the message
        if user
          @message.to = user.id
        end # if user is not found , message is rejected

        if @message.save
          render json: { messager: 'Mensagem enviada com sucesso.' }
        else
          render json: { messager: 'Houve um erro' }
        end
      end

      # index checks if user has master permission
      def index
        @messages = if current_user.master?
                      Message.master_messages.ordered
                    else
                      Message.sent_to(current_user).ordered
                    end
        render json: @messages.present? ? @messages : 'Caixa de entrada vazia!'
      end

      # shows content of the message
      def show
        @message = Message.find(params[:id])
        if @message.unread? && current_user == @message.receiver
          @message.read!
        end # only set to read if current_user is the receiver of the message
        render json: @message
      end

      # archive a single message by id
      def archive
        @message = Message.find(params[:id])
        @message.archived!

        render json: @message
      end

      # achive multiples messages by sending multiple ids
      def archive_multiple
        messages = Message.find(params[:messages_ids])
        messages.each(&:archived!)

        respond_to do |format|
          format.js
        end
      end

      # get all messages that current_user sent
      def sent
        @messages = Message.sent_from(current_user).ordered
        render json: @messages
      end

      # get all archived messages from the application
      def archived
        @messages = Message.includes(:sender).archived.ordered
      end

      private

      def message_params
        params.require(:message).permit(
          :title,
          :content,
          :receiver_email,
          :to
        )
      end

      def verify_author
        message = Message.find(params[:id])
        unless ([message.receiver, message.sender].include?(current_user) && !message.archived?) || current_user.master?
          redirect_to messages_path
        end
      end
    end
  end
end
