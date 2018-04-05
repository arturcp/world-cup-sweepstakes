# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Team, type: :model do
  describe '#default' do
    it 'has a default name' do
      expect(described_class.default.name).to eq('To confirm')
    end

    it 'has a default flag' do
      expect(described_class.default.flag).to eq('http://www.get-emoji.com/images/emoji/26bd.png')
    end
  end
end
