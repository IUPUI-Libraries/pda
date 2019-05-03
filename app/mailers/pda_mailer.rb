class PdaMailer < ActionMailer::Base
  default from: PDA.config[:email][:from]

  def book_request_email(book)
    @book = book
    mail(to: @book.email, subject: 'Books On Demand Purchase Request')
  end

  def book_request_admin_email(book)
    @book = book
    if @book.campus != 'Indianapolis' && @book.campus != ''
      mail(to: PDA.config[:email][:admin_to],
           subject: "[PDA][#{@book.campus}] Books On Demand Purchase Request",
           importance: 'High')
    else
      mail(to: PDA.config[:email][:admin_to],
           subject: '[PDA] Books On Demand Purchase Request',
           importance: 'High')
    end
  end
end
