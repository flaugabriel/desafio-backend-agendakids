# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User', type: :request do
  

  describe 'GET /api/v1/profile' do
    context 'with valid parameters' do
      it 'Show profile' do
        expect { get '/api/v1/profile' }.to change(User, :count).by(0)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /api/v1/users/2/messages' do
    context 'with valid parameters' do
      it 'List all messagers to user' do
        expect { get '/api/v1/users/2/messages' }.to change(Message, :count).by(0)
        expect(response).to have_http_status(200)
      end
    end
  end

end
