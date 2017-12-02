class ReceiptCheckoutMailerJob < ActiveJob::Base
  queue_as :default

  def perform(transaction_id)
    ReceiptMailer.receipt_email(transaction_id).deliver_later(wait: 1.second)
  end
end
