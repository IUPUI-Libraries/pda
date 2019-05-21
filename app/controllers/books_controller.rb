class BooksController < ApplicationController

  include BooksHelper

  # CAS Authentication
  before_filter CASClient::Frameworks::Rails::GatewayFilter, :get_user, :only => :index
  before_filter CASClient::Frameworks::Rails::Filter, :get_user, :except => :index
  before_filter :authorize, :except => [:index, :new, :create, :denied, :success]

  include Pagy::Backend

  def index
    @user_name = session[:cas_user]
    @login_url = CASClient::Frameworks::Rails::Filter.login_url(self)
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    unless @user[:ul_user]
      flash[:error] = 'Book request could not be completed. You must be an IUPUI student, faculty, or staff member for this service.'
      redirect_to(books_denied_path)
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)

    if @book[:name] == @user[:name]
      @book[:campus] = @user[:campus]
      @book[:department] = @user[:department]
      @book[:status] = @user[:status]
    else
      user = LdapService.fetch_info(@book[:name])
      @book[:campus] = user[:campus]
      @book[:department] = user[:department]
      @book[:status] = user[:status]
    end

    if @user[:ul_user]
      if @book.save
        PdaMailer.book_request_email(@book).deliver
        PdaMailer.book_request_admin_email(@book).deliver
        redirect_to(books_success_path(id: @book[:id]), notice: 'Great book choice! Your selection is on the way.')
      else
        redirect_to(books_index_path, notice: 'Book request could not be completed.')
      end
    else
      redirect_to(books_index_path, notice: 'Book request could not be completed. You must be affiliates with IUPUI for this service.')
    end


  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      redirect_to @book
    else
      render 'edit'
    end

  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_admin_path

  end

  def admin
    @q = Book.order('created_at desc').ransack(params[:q])
    @all_books = @q.result
    @pagy, @books = pagy(@all_books)
    @zone = ActiveSupport::TimeZone.new('Eastern Time (US & Canada)')

    respond_to do |format|
      format.html
      format.csv { send_data @all_books.to_csv }
    end
  end

  def success
    @book = Book.find(params[:id])
  end

  def my_account

    # Additional user attributes are available if your
    # CAS server is configured to provide them.
    # See http://code.google.com/p/rubycas-server/wiki/HowToSendExtraUserAttributes
    @extra_attributes = session[:cas_extra_attributes]

  end



  private

    def book_params
      params.require(:book).permit(:campus, :name, :email, :title, :utitle,
                                   :pub, :pub_date, :isbn, :iucat, :ed, :oclc,
                                   :purchase, :course)
    end

end
