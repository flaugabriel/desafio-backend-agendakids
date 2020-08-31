# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message, type: :model do
  context 'validate presence of' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_presence_of(:from) }
    it { is_expected.to validate_presence_of(:to) }
    it { should belong_to(:sender) }
    it { should belong_to(:receiver) }
  end
end
