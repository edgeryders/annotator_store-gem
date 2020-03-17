require 'current_user'

module Annotator
  module ApplicationHelper

    require_relative '../../../lib/helpers/markdown_renderer'
    include CurrentUser

    def markdown(content)
      @markdown ||= Redcarpet::Markdown.new(MarkdownRenderer, autolink: true)
      @markdown.render(content).html_safe
    end


    def nested_dropdown_with_counts(items)
      result = []
      items.each do |item, sub_items|
        path = (item.depth > 0) ? item.ancestors.map(&:name).join(' → ') + ' → ' : ''

        result << [path + "#{item.name} (#{item.annotations_count})", item.id]
        result += nested_dropdown_with_counts(sub_items) unless sub_items.blank?
      end
      result
    end


    def annotation_type_view(type)
      case type
      when 'TextAnnotation' then
        'Text'
      when 'ImageAnnotation' then
        'Image'
      when 'VideoAnnotation' then
        'Video'
      else
        type
      end
    end


    # # http://stackoverflow.com/questions/7674754/how-to-arrange-entries-from-ancestry-tree-in-dropdown-list-in-rails-3
    # def nested_dropdown(items)
    #   result = []
    #   items.map do |item, sub_items|
    #     result << [item.ancestors.map(&:name).join(' → ') + (item.ancestors.present? ? ' → ' : '') + item.name, item.id]
    #     result += nested_dropdown(sub_items) unless sub_items.blank?
    #   end
    #   result
    # end


    # def nested_dropdown_with_dashes(items)
    #   result = []
    #   items.map do |item, sub_items|
    #     result << [('- ' * item.depth) + item.name_with_count, item.id]
    #     result += nested_dropdown(sub_items) unless sub_items.blank?
    #   end
    #   result
    # end


  end
end
