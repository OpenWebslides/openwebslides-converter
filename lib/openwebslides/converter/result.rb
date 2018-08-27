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

      def to_s
        "#{title} by #{author}"
      end
    end
  end
end
