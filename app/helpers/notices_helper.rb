module NoticesHelper
  def authorize
    unless admin?
      flash[:error] = 'Unauthorized access'
      redirect_to root_path
    end
    @admin = true
  end
end
