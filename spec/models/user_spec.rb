# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validate presence of' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should have_many(:messages) }
  end
end
