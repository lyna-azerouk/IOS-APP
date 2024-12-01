require 'active_record'
require 'enumerize'
require 'openssl'
require 'base64'

class Wallet < ActiveRecord::Base
  extend Enumerize

  KEY = "\x18\xDF\xFE\xFE\xEDw=\xF0\xC3\xE8\xA9|\x8E\xA1k\xB8\x7F^\xBCZ&6\xF3\xA4\xF8r\x0F$\xD5\xDC\xD89"

  belongs_to :user, optional: false

  validates :csv, :name, :number, :exprired_at, presence: true
  validates :number, uniqueness: true
  validate :number_lenght?
  validate :luhn_valid?

  enumerize :name, in: [:visa, :mastercard, :american_express]

  def get_wallet
    {
      number: self.decrypt_number,
      name: self.name,
      csv: self.csv,
      exprired_at: self.exprired_at
    }
  end

  def encrypt_number
    cipher = OpenSSL::Cipher.new("AES-256-CBC")
    cipher.encrypt
    cipher.key = KEY
    encrypted = cipher.update(self.number) + cipher.final
    self.number = Base64.encode64(encrypted)
  end

  private

  def luhn_valid?
    digits =self. number.to_s.chars.map(&:to_i)
    checksum = digits.reverse.each_with_index.map do |digit, index|
      if index.odd?
        double = digit * 2
        double > 9 ? double - 9 : double
      else
        digit
      end
    end.sum
    errors.add(:number, "is invalid") unless checksum % 10 == 0
  end

  def number_lenght?
    case self.name
    when "visa"
      errors.add :number, :length, message: "invalid length for type visa"  if self.number.length != 16
    when "mastercard"
      errors.add :number, :length, message: "invalid length for type mastercard" if self.number.length != 16
    when "american_express"
      errors.add :number, :length, message: "invalid length for type american_express" if self.number.length != 15
    else
      false
    end
  end

  def decrypt_number
    cipher = OpenSSL::Cipher.new("AES-256-CBC")
    cipher.decrypt
    cipher.key = KEY
    encrypted_number = Base64.decode64(self.number)
    cipher.update(encrypted_number) + cipher.final
  end
end