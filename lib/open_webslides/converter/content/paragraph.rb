# frozen_string_literal: true

module OpenWebslides
  module Converter
    module Content
      class Paragraph < ContentItem
        include Properties::Metadata
        include Properties::Subable
        include Properties::Text
      end
    end
  end
end
