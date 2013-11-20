module HasDefaultValues
  extend ActiveSupport::Concern

  included do
    cattr_accessor(:default_values) { {} }
  end

  def initialize(attributes = {}, &block)
    default_values.each do |name, value|
      value = value.respond_to?(:call) ? value.call : value
      attributes[name] = value unless attributes[name]
    end

    super attributes, &block
  end

  module ClassMethods
    def default_to(name, value = nil, &block)
      default_values[name] = value || block
    end
  end
end