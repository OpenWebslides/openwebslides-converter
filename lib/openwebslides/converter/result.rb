# frozen_string_literal: true

module OpenWebslides
  module Converter
    class Result
      attr_accessor :title,
                    :author,
                    :license,
                    :content_items

      def initialize
        @content_items = []
      end
    end
  end
end
