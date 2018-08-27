# frozen_string_literal: true

require 'nokogiri'

module OpenWebslides
  module Converter
    class Pressbooks
      include Helpers::Sanitization

      attr_accessor :html,
                    :result

      ##
      # Convert an XHTML document to Open Webslides
      #
      # @param [String] html XHTML document string
      # @return [Result] Result object containing all data
      #
      def from_xhtml(html)
        @html = Nokogiri::HTML html
        @result = Result.new

        parse_metadata

        parse_front_matter
        parse_chapters
        parse_back_matter

        result
      end

      protected

      ##
      # Find and parse metadata
      #
      def parse_metadata
        @result.title = html.at('meta[name="pb-title"]')['content']
        @result.author = html.at('meta[name="pb-authors"]')['content']
        @result.license = html.at('meta[name="pb-book-license"]')['content']
      end

      ##
      # Find and parse front matter
      #
      def parse_front_matter
        # Create new heading
        heading = Content::Heading.new

        # Set title
        heading.text = html.at('.front-matter-title').content

        paragraphs = Array.new

        # Extract paragraphs
        html.search('.front-matter p').each do |paragraph|
          paragraphs << parse_paragraph(paragraph)
        end

        heading.sub_item_ids = paragraphs.map { |p| p.id }

        # Add heading and paragraphs to result
        result.content_items << heading
        result.content_items.concat paragraphs
      end

      ##
      # Find and parse chapters
      #
      def parse_chapters; end

      ##
      # Find and parse back matter
      #
      def parse_back_matter; end

      ##
      # Parse paragraph XHTML object into content item
      #
      def parse_paragraph(html)
        paragraph = Content::Paragraph.new

        paragraph.text = sanitize html.content

        paragraph
      end
    end
  end
end
