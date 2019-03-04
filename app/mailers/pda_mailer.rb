class PdaMailer < ActionMailer::Base
  default from: PDA.config[:email][:from]

  def book_request_email(book)
    @book = book
    mail(to: @book.email, subject: 'Books On Demand Purchase Request')
  end

  def book_request_admin_email(book)
    @book = book
    mail(to: PDA.config[:email][:admin_to], subject: '[PDA] Books On Demand Purchase Request', importance: 'High')
  end

end
