class NoticesController < ApplicationController

  include NoticesHelper

  # CAS Authentication
  # before_filter CASClient::Frameworks::Rails::GatewayFilter, :get_user, :only => :index
  # before_filter CASClient::Frameworks::Rails::Filter, :get_user, :except => :index
  before_filter :authorize

  def index
    @notices = Notice.all
  end

  def show
    @notice = Notice.find(params[:id])
  end

  def new
  end

  def edit
    @notice = Notice.find(params[:id])
  end

  def create
    @notice = Notice.new(notice_params)

    @notice.save
    redirect_to notices_path
  end

  def update
    @notice = Notice.find(params[:id])

    if @notice.update(notice_params)
      redirect_to notices_path
    else
      render 'edit'
    end
  end

  def destroy
    @notice = Notice.find(params[:id])
    @notice.destroy
    redirect_to notices_path
  end

  private

  def notice_params
    params.require(:notice).permit(:message, :display)
  end
end
