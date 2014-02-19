Your::Application.routes.draw do
  resource :session, :only => %w(new create destroy)
end
