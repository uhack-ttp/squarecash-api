class ReceiptMailer < ApplicationMailer
  default from: 'SquareCash <noreply@squarecash.com>'

  def receipt_email(transaction_id)
    @transaction = Transaction.find(transaction_id)

    mail({
           to: @transaction.customer.email,
           from: 'SquareCash <noreply@squarecash.com>',
           subject: 'SquareCash | Transaction Receipt'
         }) do |format|
      format.text
      format.html
    end
  end
end
