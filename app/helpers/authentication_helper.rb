module AuthenticationHelper
  def authenticate
    if request.headers['HTTP_AUTHORIZATION']
      authenticate_with_http_basic do |email, password|
        authenticate! User.authenticate(email, password)
      end
    end

    unauthorized! unless current_user
  end

  def authenticate!(user)
    session[:current_user] = user.try(:id)
  end

  def unauthorized!
    respond_to do |format|
      format.html do
        redirect_to(new_session_path)
      end

      format.any do
        head(:unauthorized)
      end
    end
  end

  def current_user
    @current_user ||= User.where(:id => session[:current_user]).first
  end
end
