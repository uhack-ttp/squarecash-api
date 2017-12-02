class ApiKey < ApplicationRecord
  before_validation :set_auth_token
  before_validation :generate_expiration_date

  validates :name, presence: true
  validates :token, presence: true
  validates :domains, presence: true
  validates :expires_at, presence: true

  private

  def set_auth_token
    return if token.present?
    self.token = generate_auth_token
  end

  def generate_auth_token
    SecureRandom.uuid.gsub(/\-/,'')
  end

  def generate_expiration_date
    self.expires_at = Date.today + 1.year
  end
end
