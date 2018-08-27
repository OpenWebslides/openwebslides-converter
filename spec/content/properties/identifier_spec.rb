# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Content::Properties::Identifier do
  ##
  # Configuration
  #
  ##
  # Stubs and mocks
  #
  ##
  # Test variables
  #
  let(:object) do
    obj = Object.new
    obj.extend described_class
  end

  ##
  # Subject
  #
  subject { object }

  ##
  # Tests
  #
  describe 'included properties' do
    it { is_expected.to respond_to :id }
    it { is_expected.to respond_to :to_h }

    it 'sets a default value for the property' do
      expect(subject.id).not_to be_nil
    end
  end

  describe 'methods' do
    describe '#to_h' do
      it 'returns a hash with the property' do
        expect(subject.to_h).to include :id
      end
    end

    describe '#generate_id' do
      it 'returns a 10-digit string' do
        expect(subject.send :generate_id).to be_a String
        expect(subject.send(:generate_id).length).to eq 10
      end
    end
  end
end
