# frozen_string_literal: true

require 'spec_helper'
require 'openwebslides/converter'

describe OpenWebslides::Converter do
  it 'should have a VERSION constant' do
    expect(OpenWebslides::Converter::VERSION).to_not be_empty
  end
end
