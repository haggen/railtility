module Scopable
  extend ActiveSupport::Concern

  included do
    cattr_reader :scopes do
      Hash.new
    end
  end

  def active_scopes
    scopes.select do |name, scope|
      scope[:active]
    end
  end

  def scoped(resource, params)
    scopes.each do |name, scope|
      param, force, default, body = scope.values_at(:param, :force, :default, :body)

      param = param || name
      value = force || params[param] || default

      if value.blank? || value.to_s =~ /\A(false|no|off)\z/
        scope.update(:active => false)
      else
        scope.update(:active => true)

        value = nil if value == 'nil'

        if body
          resource = self.instance_exec(resource, value, &body)
        else
          if value.to_s =~ /\A(true|yes|on)\z/
            resource = resource.send(name)
          else
            resource = resource.send(name, value)
          end
        end
      end
    end

    resource
  end

  module ClassMethods
    def scope(name, options = {}, &body)
      scopes.store name, options.merge(:body => body)
    end
  end
end
