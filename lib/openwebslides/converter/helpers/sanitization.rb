# frozen_string_literal: true

module OpenWebslides
  module Converter
    module Helpers
      module Sanitization
        ##
        # Sanitize a string
        # @param [String] text
        # @return [String]
        #
        def sanitize(text)
          text.gsub(/[[:space:]]+/, " ")
              .strip
        end
      end
    end
  end
end
