# frozen_string_literal: true

module OpenWebslides
  module Converter
    module Content
      module Properties
        module Text
          attr_accessor :text

          def text
            @text ||= ''
          end

          def to_h
            super.merge :text => text
          end
        end
      end
    end
  end
end
