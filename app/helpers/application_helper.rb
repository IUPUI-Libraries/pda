module ApplicationHelper

  def get_user
    @user_name = session[:cas_user]
    @user = get_ldap_user(session[:cas_user])
    @admin = admin?
  end

  def admin?
    @admins = PDA.config[:admins]
    @admins.include?(session[:cas_user])
  end

end
