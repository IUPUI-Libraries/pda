class UserInfoController < ApplicationController

  before_filter :authorize, :except => [:index, :new, :create, :denied, :success]

  def new

  end

  def success
    @username = params[:user_info][:username]
    @info = LdapService.fetch_info(@username)
  end

end
