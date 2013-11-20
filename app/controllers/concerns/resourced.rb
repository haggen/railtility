module Resourced
  extend ActiveSupport::Concern

  included do
    respond_to :html, :json
  end

  protected

  def fetch_resource
    if params[:id]
      set_resource collection.find(params[:id])
    else
      set_resource scoped(collection)
    end
  end

  def new_resource
    set_resource collection.new
  end

  def save_resource(params = resource_params)
    @resource.update_attributes(params)
  end

  def destroy_resource
    @resource.destroy
  end

  def set_resource(value)
    @resource = value
    c, k, name = value.class, resource, resource_name
    instance_variable_set "@#{c == k ? name : name.pluralize}", value
  end

  def parent_resource
    nil
  end

  def parent_resource_name
    parent_resource.model_name.singular
  end

  def resource
    controller_name.classify.constantize
  end

  def resource_name
    resource.model_name.singular
  end

  def collection
    if parent_resource 
      parent_resource.send(resource_name.pluralize)
    else
      resource
    end
  end

  def resource_params
    send "#{resource_name}_params"
  end

  def respond_with_resource(&block)
    respond_with @resource, :location => response_location, &block
  end

  def response_location
    @response_location || url_for [parent_resource, resource_name.pluralize]
  end

  def flash_notice(action)
    return if request.xhr?
    default = t("flash.#{action}", flash_params)
    params = flash_params.merge(:default => default)
    flash[:notice] = t("flash.#{resource_name}.#{action}", params)
  end

  def flash_params
    resource_path = url_for(parent_resource ? [parent_resource, @resource] : @resource)
    {:path => resource_path, :name => resource.model_name.human}
  end
end
