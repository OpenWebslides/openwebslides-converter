# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Content::Properties::Type do
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
    # Always include Identifier as top of the #to_h chain
    obj.extend Content::Properties::Identifier
    obj.extend described_class

    obj
  end

  ##
  # Subject
  #
  subject { object }

  ##
  # Tests
  #
  describe 'included properties' do
    it { is_expected.to respond_to :type }
    it { is_expected.to respond_to :to_h }

    it 'sets a default value for the property' do
      expect(subject.type).not_to be_nil
    end
  end

  describe 'methods' do
    describe '#to_h' do
      it 'returns a hash with the property' do
        expect(subject.to_h).to include :type
      end
    end
  end
end
