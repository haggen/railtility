Your::Application.routes.draw do
  resource :session, :controller => :session, :only => %w(new create destroy)
end
