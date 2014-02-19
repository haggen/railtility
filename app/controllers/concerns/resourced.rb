module Resourced
  extend ActiveSupport::Concern

  included do
    # Allow us to dynamically change layout
    layout :set_layout

    # Respond to HTML and JSON by default
    respond_to :html, :json
  end

  protected

  # Fetch a single resource when possible, 
  # or an entire collection, applying scopes if any
  def find_resource
    if params[:id]
      set_resource resource_collection.find(params[:id])
    else
      set_resource scoped(resource_collection)
    end
  end

  # Initialize a new resource and assign it
  # to the appropriate instance variable
  def new_resource
    set_resource(resource_collection.new)
  end

  # Assign resource parameters and try to save it
  def save_resource(params = nil)
    current_resource.assign_attributes(params || resource_params)
    current_resource.save
  end

  alias :update_resource :save_resource
  alias :create_resource :save_resource

  # Try to destroy the resource
  def destroy_resource
    current_resource.destroy
  end

  # Assign the appropriate instance variable
  # for the resource or collection given
  def set_resource(value)
    @current_resource = value
    c, k, name = value.class, resource, resource_name
    instance_variable_set "@#{c == k ? name : name.pluralize}", value
  end

  # Retrieve current set resource
  def current_resource
    @current_resource
  end
  
  # An array of resource parents
  def resource_parents
    []
  end

  # Retrieve resource's model from the controller's name
  def resource
    controller_name.classify.constantize
  end

  # Retrieve resource collection
  def resource_collection
    resource
  end

  # Retrieve resource's name in singular as symbol
  def resource_name
    resource.model_name.singular
  end

  # Fetch single resource path when possible, 
  # otherwise return collection's path
  def resource_path
    m, n  = resource_parents, current_resource
    url_for(m + [n.is_a?(resource) ? n : resource_name.pluralize])
  end

  # Retrieve resource parameters accordingly to the action
  def resource_params
    default = "#{resource_name}_params".to_sym
    send("#{action_name}_#{default}".to_sym) rescue send(default)
  end

  # Respond with the current resource and location
  def respond_with_resource(location = nil, &block)
    respond_with(current_resource, :location => location || response_location, &block)
  end

  # Retrieve default response location after a POST, PATCH or DELETE
  def response_location
    resource_path
  end

  # Retrieve appropriate message from the locale strings hash
  # and assign it as notice, passing the flash_params content
  def flash_notice(action)
    return if request.xhr?
    default = t("flash.#{action}", flash_params)
    params = flash_params.merge(:default => default)
    flash[:notice] = t("flash.#{resource_name}.#{action}", params)
  end

  # Params to be used with the flash message
  def flash_params
    {:path => resource_path, :name => resource.model_name.human}
  end

  # Disable layout when AJAX
  def set_layout
    request.xhr? ? false : nil
  end
end
