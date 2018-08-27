# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Content::ContentItem do
  ##
  # Configuration
  #
  ##
  # Stubs and mocks
  #
  ##
  # Test variables
  #
  ##
  # Subject
  #
  ##
  # Tests
  #
  describe 'included properties' do
    it { is_expected.to respond_to :id }
    it { is_expected.to respond_to :type }
  end
end
