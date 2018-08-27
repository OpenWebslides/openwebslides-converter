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

          ##
          # Convert property to hash
          #
          # This is the start of the chain of overridden #to_h methods.
          # In all subsequent included property modules, #to_h should call
          # `super.merge :property => property`
          #
          def to_h
            { :id => id }
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
