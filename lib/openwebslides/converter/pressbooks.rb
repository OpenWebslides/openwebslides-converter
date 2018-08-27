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

        root = Content::Root.new

        parse_metadata

        root.child_item_ids << parse_front_matter
        root.child_item_ids.concat parse_parts
        root.child_item_ids << parse_back_matter

        # result.content_items << root

        result
      end

      protected

      ##
      # Find and parse metadata
      #
      def parse_metadata
        result.title = html.at('meta[name="pb-title"]')['content']
        result.author = html.at('meta[name="pb-authors"]')['content']
        result.license = html.at('meta[name="pb-book-license"]')['content']
      end

      ##
      # Find and parse front matter
      #
      def parse_front_matter
        # Create new heading
        heading = Content::Heading.new

        # Set title
        heading.text = html.at('.front-matter-title').content

        # Parse front matter paragraphs
        paragraphs = html.search('.front-matter p').map { |p| parse_paragraph p }

        # Add paragraphs to the front matter header
        heading.sub_item_ids = paragraphs.map &:id
        result.content_items.concat paragraphs

        # Add front matter heading to result
        result.content_items << heading

        heading
      end

      ##
      # Find and parse parts
      #
      def parse_parts
        parts = html.search('div.part').map do |part|
          # Create new heading
          heading = Content::Heading.new

          # Set title
          heading.text = part.at('.part-title').content

          # Part intro (paragraphs under part header)
          intro = part.search('p').map { |p| parse_paragraph p }
          heading.sub_item_ids = intro.map &:id
          result.content_items.concat intro

          # Parse part chapters
          chapters = part.search('.chapter').map { |c| parse_chapter c}

          if chapters.any?
            # Add paragraphs to the part header
            heading.sub_item_ids.concat chapters.map &:id
            result.content_items.concat chapters
          end

          # Add part heading to result
          result.content_items << heading

          heading
        end

        parts
      end

      ##
      # Parse chapter XHTML object into content item
      #
      def parse_chapter(html)
        # Create new heading
        heading = Content::Heading.new

        # Set title
        heading.text = html.at('.chapter-title').content

        # Parse chapter paragraphs
        paragraphs = html.search('p').map { |p| parse_paragraph p }

        # Add paragraphs to the chapter heading
        heading.sub_item_ids = paragraphs.map &:id
        result.content_items.concat paragraphs

        # Add chapter heading to result
        result.content_items << heading

        heading
      end

      ##
      # Find and parse back matter
      #
      def parse_back_matter; end

      ##
      # Parse paragraph XHTML object into content item
      #
      def parse_paragraph(html)
        # Create new paragraph
        paragraph = Content::Paragraph.new

        # Extract and sanitize paragraph contents
        paragraph.text = sanitize html.content

        paragraph
      end
    end
  end
end
