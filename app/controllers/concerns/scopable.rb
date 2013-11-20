module Scopable
  extend ActiveSupport::Concern

  included do
    cattr_accessor(:scopes) { [] }
    cattr_accessor(:current_scopes) { [] }

    def self.scope(name, options = {}, &block)
      options.update(:name => name, :block => block)
      scopes.push(options)
    end
  end

  def scoped(resource)
    self.scopes.each do |scope|
      name, param, default, block = scope.values_at(:name, :param, :default, :block)

      param = param || name
      value = params[param] || default

      unless value.nil?
        current_scopes.push(name)

        if block
          resource = block.call(resource, value, self)
        else
          if value.to_s =~ /true|false|yes|no|on|off/
            resource = resource.send(scope[:name])
          else
            resource = resource.send(scope[:name], value)
          end
        end
      end
    end

    case resource
      when Hash
        resource
      else
        resource.all
    end
  end
end
