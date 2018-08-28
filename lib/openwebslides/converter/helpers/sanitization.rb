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
          text.gsub(/[[:space:]]+/, ' ')
              .gsub(/_&nbsp;_/, '')
              .strip
              .gsub(/\A&nbsp;\z/, '')
        end
      end
    end
  end
end
