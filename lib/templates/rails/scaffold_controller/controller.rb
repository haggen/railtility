<% if namespaced? -%>
require_dependency "<%= namespaced_file_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  include Scopable

  scope :find, :param => :id

  def index
    @<%= plural_table_name %> = <%= singular_table_name %>_scope.all
    respond_with(@<%= plural_table_name %>)
  end

  def show
    @<%= singular_table_name %> = <%= singular_table_name %>_scope
    respond_with(@<%= singular_table_name %>)
  end

  def new
    @<%= singular_table_name %> = <%= singular_table_name %>_scope.new
    respond_with(@<%= singular_table_name %>)
  end

  def edit
    @<%= singular_table_name %> = <%= singular_table_name %>_scope
    respond_with(@<%= singular_table_name %>)
  end

  def create
    @<%= singular_table_name %> = <%= singular_table_name %>_scope.new(<%= singular_table_name %>_params)
    @<%= singular_table_name %>.save
    respond_with(@<%= singular_table_name %>)
  end

  def update
    @<%= singular_table_name %> = <%= singular_table_name %>_scope
    @<%= singular_table_name %>.update(<%= singular_table_name %>_params)
    respond_with(@<%= singular_table_name %>)
  end

  def destroy
    @<%= singular_table_name %> = <%= singular_table_name %>_scope
    @<%= singular_table_name %>.destroy
    respond_with(@<%= singular_table_name %>)
  end

  private

  def <%= singular_table_name %>_scope
    scoped(<%= class_name %>, params)
  end

  def <%= "#{singular_table_name}_params" %>
    <%- if attributes_names.empty? -%>
    params[:<%= singular_table_name %>]
    <%- else -%>
    params.require(:<%= singular_table_name %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
    <%- end -%>
  end
end
<% end -%>
