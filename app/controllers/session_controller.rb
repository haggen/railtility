class SessionsController < ApplicationController
  def new
    @session = Session.new
  end

  def create
    @session = Session.new(session_params)

    if @session.valid?
      authorize @session.user
      redirect_to params[:return_to] || root_path
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
