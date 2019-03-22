class UserInfoController < ApplicationController

  def new

  end

  def success
    @username = params[:user_info][:username]
    @info = LdapService.fetch_info(@username)
  end

end
