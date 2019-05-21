module BooksHelper
  include Pagy::Frontend

  def get_ldap_user(cas_name)
    user = LdapService.fetch_info(cas_name)
    return user unless admin? && params['pseudo_user']
    pseudo_user = LdapService.fetch_info(params['pseudo_user'])
    pseudo_user[:email] = 'pseudo@nowhere.edu'
    pseudo_user
  end



  def authorize
    unless admin?
      flash[:error] = 'Unauthorized access'
      redirect_to action: 'index'
    end
    @admin = true
  end
end
