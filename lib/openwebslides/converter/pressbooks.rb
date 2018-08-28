# frozen_string_literal: true

require 'nokogiri'
require 'reverse_markdown'

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

        root.child_item_ids << parse_matter('front').id
        root.child_item_ids.concat parse_parts.map(&:id)
        root.child_item_ids << parse_matter('back').id

        result.content_items << root

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
      # Find and parse matter
      #
      # @param [String] position 'front' or 'back'
      #
      def parse_matter(position)
        # Create new heading
        heading = Content::Heading.new

        # Set title
        heading.text = html.at(".#{position}-matter-title").content

        # Parse front matter paragraphs
        paragraphs = parse_paragraphs html.at(".#{position}-matter")

        # Add paragraphs to the front matter header
        heading.sub_item_ids = paragraphs.map(&:id)

        # Add front matter heading to result
        result.content_items << heading

        heading
      end

      ##
      # Find and parse parts
      #
      def parse_parts
        parts = []

        html.search('div.part, div.chapter').each do |div|
          if div.classes.include? 'part'
            # Create new part heading
            parts << Content::Heading.new

            # Set title
            parts.last.text = div.at('.part-title').content

            # Part intro (paragraphs under part header)
            intro = parse_paragraphs div

            # Add intro to part
            parts.last.sub_item_ids = intro.map(&:id)
          elsif div.classes.include? 'chapter'
            chapter = parse_chapter div

            # Add chapter heading to the part
            parts.last.sub_item_ids << chapter.id
          end
        end

        # Add parts to result
        result.content_items.concat parts

        parts
      end

      ##
      # Parse chapter XHTML object into content item
      def parse_chapter(html)
        # Create new chapter
        chapter = Content::Heading.new

        # Set title
        chapter.text = html.at('.chapter-title').content

        # Add chapter heading to result
        result.content_items << chapter

        # Start with chapter heading as current heading
        heading = chapter

        # Parse chapter content
        html.at('.chapter-ugc').children.each do |child|
          if child.name == 'p'
            # Parse paragraph
            paragraph = parse_paragraph child

            # Add paragraph to current heading
            heading.sub_item_ids << paragraph.id
          elsif child.name == 'h4'
            # Create new heading
            h = Content::Heading.new

            # Set title
            h.text = child.content

            # Add heading to result
            result.content_items << h

            # Add heading to current heading
            chapter.sub_item_ids << h.id

            # Replace current heading
            heading = h
          elsif child.name == 'ul'

          end
        end

        chapter
      end

      ##
      # Parse XHTML object into paragraph content items
      #
      def parse_paragraphs(html)
        html.search('p').map { |p| parse_paragraph p }
      end

      ##
      # Parse paragraph XHTML object into content item
      #
      def parse_paragraph(html)
        # Create new paragraph
        paragraph = Content::Paragraph.new

        # Extract and sanitize paragraph contents
        paragraph.text = sanitize ReverseMarkdown.convert html.to_xhtml

        return nil if paragraph.text.empty?

        # Add paragraph to result
        result.content_items << paragraph

        paragraph
      end
    end
  end
end
