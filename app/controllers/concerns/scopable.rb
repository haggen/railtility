module Scopable
  extend ActiveSupport::Concern

  included do
    cattr_accessor(:scopes) {[]}

    def self.scope(name = nil, options = {}, &block)
      scopes.push options.update(:name => name, :block => block)
    end
  end

  def scoped(resource)
    resource = scopes.reduce(resource) do |resource, scope|
      name, param, force, default, block = scope.values_at(:name, :param, :force, :default, :block)

      param = param || name
      value = force || params[param] || default

      if value.blank? || value.to_s =~ /\A(false|no|off)\z/
        resource
      else
        scope[:active] = true

        # Cast 'nil' value
        value = nil if value == 'nil'

        if block
          block.call(resource, value, self)
        else
          if value.to_s =~ /\A(true|yes|on)\z/
            resource.send(scope[:name])
          else
            resource.send(scope[:name], value)
          end
        end
      end
    end

    resource.try(:all) or resource
  end

  def active_scopes
    scopes.select do |scope|
      scope[:active] == true
    end
  end
end
