module Breadcrumb
  extend ActiveSupport::Concern

  included do
    class_attribute :_breadcrumb

    helper_method :breadcrumb

    def self.breadcrumb_for(*args)
      self._breadcrumb ||= []
      options = args.pop
      _breadcrumb.push([args, options])
    end
  end

  def breadcrumb
    @breadcrumb ||= Array.wrap(_breadcrumb).map do |item|
      if item[0].include?(params[:action].to_sym) || item[0][0] == '*'

        text, href = item[1].values_at(:text, :href)

        if text.respond_to?(:call)
          text = instance_eval(&text)
        end

        if href.respond_to?(:call)
          href = instance_eval(&href)
        end

        [text, href]
      end
    end.compact
  end
end