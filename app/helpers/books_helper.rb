module BooksHelper

  def get_user
    @user_name = session[:cas_user]
    @user = get_ldap_user(session[:cas_user])
    @admin = admin?
  end

  def get_ldap_user(cas_name)
    user = {}
    user[:ul_user] = false
    ldap = Net::LDAP.new
    ldap.host = PDA.config[:ldap][:host]
    auth_user = ["cn=#{PDA.config[:ldap][:auth][:user]}", PDA.config[:ldap][:auth][:base]].join(',')
    ldap.auth auth_user, PDA.config[:ldap][:auth][:pass]
    if ldap.bind
      filter = Net::LDAP::Filter.eq('cn', cas_name)
      treebase = PDA.config[:ldap][:treebase]
      result_attrs = ['sAMAccountName', 'displayName', 'mail', 'memberof']
      ldap.search(base: treebase, filter: filter, attributes: result_attrs) do |item|
        user[:name] = item.sAMAccountName.first
        user[:display_name] = item.displayName.first
        user[:email] = item.mail.first
        # Check for members for UL users
        members = item.memberof
        user[:members] = members
        ul_groups = PDA.config[:ldap][:groups]
        members.each do |member|
          group = /^CN=(.*?),/.match(member).captures
          if ul_groups.include?(group[0])
            Rails.logger.info 'Library user found.'
            user[:ul_user] = true
          end
        end
      end
    else
      Rails.logger.info "LDAP Bind failed: #{ldap.get_operation_result}."
    end
    user
  end

  def admin?
    @admins = PDA.config[:admins]
    return true if @admins.include?(@user_name)
    false
  end

  def authorize
    unless admin?
      flash[:error] = 'Unauthorized access'
      redirect_to action: 'index'
    end
    @admin = true
  end
end
