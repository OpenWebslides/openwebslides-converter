# frozen_string_literal: true

require 'spec_helper'
require 'open_webslides/converter'

describe OpenWebslides::Converter do
  it 'should have a VERSION constant' do
    expect(subject.const_get('VERSION')).to_not be_empty
  end
end
