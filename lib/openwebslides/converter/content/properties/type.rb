# frozen_string_literal: true

module OpenWebslides
  module Converter
    module Content
      module Properties
        module Type
          attr_accessor :type

          def type
            "contentItemTypes/#{self.class.name.split('::').last.upcase}"
          end

          def to_h
            super.merge :type => type
          end
        end
      end
    end
  end
end
