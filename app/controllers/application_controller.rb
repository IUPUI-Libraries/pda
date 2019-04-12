class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :make_action_mailer_use_request_host_and_protocol

  include ApplicationHelper

  private

  def make_action_mailer_use_request_host_and_protocol
    ActionMailer::Base.default_url_options[:protocol] = request.protocol
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
    ActionMailer::Base.asset_host = request.protocol + request.host_with_port
  end

  def logout
    # optionally do some local cleanup here

    CASClient::Frameworks::Rails::Filter.logout(self)
  end
end
