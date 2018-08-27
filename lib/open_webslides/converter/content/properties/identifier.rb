# frozen_string_literal: true

module OpenWebslides
  module Converter
    module Content
      module Properties
        module Identifier
          attr_accessor :id

          def id
            @id ||= generate_id
          end

          def to_h
            h = { :id => id }
            defined?(super) ? super.merge(h) : h
          end

          private

          ##
          # Generate a random 10-digit alphanumeric identifier
          #
          # @return [String] identifier
          #
          def generate_id
            r = ('a'..'z').to_a + ('0'..'9').to_a

            10.times.map { r.sample }.join
          end
        end
      end
    end
  end
end
