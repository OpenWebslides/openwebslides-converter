# frozen_string_literal: true

module OpenWebslides
  module Converter
    module Content
      module Properties
        module Subable
          attr_accessor :sub_item_ids

          def sub_item_ids
            @sub_item_ids ||= []
          end

          def to_h
            super.merge :sub_item_ids => sub_item_ids
          end
        end
      end
    end
  end
end
