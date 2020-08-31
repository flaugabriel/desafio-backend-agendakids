# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Message', type: :request do
  describe 'GET /api/v1/messages' do
    context 'with valid parameters' do
      it 'List all messagers' do
        expect { get '/api/v1/messages' }.to change(Message, :count).by(0)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST /api/v1/messages' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          receiver_email: 'fakeEmail@email.com',
          to: 'faketeste@email.com',
          title: 'Test1',
          content: 'testetext'
        }
      end

      it 'creates a new messages' do
        expect { post '/api/v1/messages', params: valid_params }.to change(Message, :count).by(0)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /api/v1/messages/sent' do
    context 'with valid parameters' do
      it 'List all messagers sent' do
        expect { get '/api/v1/messages/sent' }.to change(Message, :count).by(0)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /api/v1/messages/archived' do
    context 'with valid parameters' do
      it 'List all messagers archived' do
        expect { get '/api/v1/messages/archived' }.to change(Message, :count).by(0)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /api/v1/messages/1' do
    context 'with valid parameters' do
      it 'show messages' do
        expect { get '/api/v1/messages/1' }.to change(Message, :count).by(0)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'PATCH /api/v1/messages/1/archive' do
    context 'with valid parameters' do
      it 'achive messages' do
        expect { patch '/api/v1/messages/1/archive' }.to change(Message, :count).by(0)
        expect(response).to have_http_status(200)
      end
    end
  end
end
