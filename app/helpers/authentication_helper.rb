module AuthenticationHelper
  def next_path(location = nil)
    params[:next] || location || request.referrer
  end

  def authenticate
    if request.headers['HTTP_AUTHORIZATION']
      authenticate_with_http_basic do |email, password|
        authenticate! User.authenticate(email, password)
      end
    end

    unless current_user
      respond_to do |format|
        format.html do
          redirect_to new_session_path(:next => next_path)
        end

        format.any do
          render :text => '', :status => :unauthorized
        end
      end
    end
  end

  def authenticate!(user)
    session[:current_user] = user.try(:id)
  end

  def current_user
    @current_user ||= User.where(:id => session[:current_user]).first
  end
end
