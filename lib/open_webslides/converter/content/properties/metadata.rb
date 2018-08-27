# frozen_string_literal: true

module OpenWebslides
  module Converter
    module Content
      module Properties
        module Metadata
          attr_accessor :metadata

          def metadata
            @metadata ||= {
              :tags => [],
              :visibility_overrides => {}
            }
          end

          def to_h
            super.merge :metadata => metadata
          end
        end
      end
    end
  end
end
