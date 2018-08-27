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
            h = { :type => type }
            defined?(super) ? super.merge(h) : h
          end
        end
      end
    end
  end
end
