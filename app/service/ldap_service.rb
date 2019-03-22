require 'net/ldap'

module LdapService

  def self.fetch_info(username)
    info = {}
    ldap = Net::LDAP.new
    ldap.host = PDA.config[:ldap][:host]
    auth_user = ["cn=#{PDA.config[:ldap][:auth][:user]}", PDA.config[:ldap][:auth][:base]].join(',')
    ldap.auth auth_user, PDA.config[:ldap][:auth][:pass]
    if ldap.bind
      filter = Net::LDAP::Filter.eq('cn', username)
      attrs = %w[mail sn memberof department l]
      treebase = PDA.config[:ldap][:treebase]
      ldap.search(base: treebase, filter: filter, attributes: attrs) do |entry|
        info[:email] = entry.mail[0]
        info[:name] = entry.sn[0]
        info[:campus] = entry.l[0]
        info[:department] = entry.department[0]
        # info[:roles] = ldap_roles(entry.memberof)
      end
    else
      Rails.logger.warn "LDAP Bind Failed : #{ldap.get_operation_result}"
    end
    info
  end

  def self.ldap_roles(groups)
    roles = []
    groups.each do |group|
      PDA.config[:roles].each do |role, ldap_groups|
        roles << role if group[3..-1].start_with?(*ldap_groups)
      end
    end
    roles
  end
end
