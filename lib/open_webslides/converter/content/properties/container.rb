# frozen_string_literal: true

module OpenWebslides
  module Converter
    module Content
      module Properties
        module Container
          attr_accessor :child_item_ids

          def child_item_ids
            @child_item_ids ||= []
          end

          def to_h
            super.merge :child_item_ids => child_item_ids
          end
        end
      end
    end
  end
end
