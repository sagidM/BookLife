module PaginationHelpers
  module RemoteLinkPaginationHelper
    class LinkRenderer < WillPaginate::ActionView::LinkRenderer
      # def link(text, target, attributes = {})
      #   attributes['data-remote'] = true
      #   super
      # end
      def prepare(collection, options, template)
        options[:params] ||= {}
        options[:params]['_'] = nil
        super(collection, options, template)
      end

      protected
      def link(text, target, attributes = {})
        if target.is_a? Fixnum
          attributes[:rel] = rel_value(target)
          target = url(target)
        end

        @template.link_to(target, attributes.merge(remote: true)) do
          text.to_s.html_safe
        end
      end
    end
  end
end
