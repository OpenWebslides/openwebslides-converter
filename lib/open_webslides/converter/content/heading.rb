# frozen_string_literal: true

module OpenWebslides
  module Converter
    module Content
      class Heading < ContentItem
        include Properties::Metadata
        include Properties::Subable
        include Properties::Text
      end
    end
  end
end
