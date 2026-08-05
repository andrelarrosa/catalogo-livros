class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :books, dependent: :destroy
  has_many :authors, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :email_address, presence: true, uniqueness: true,
                            format: { with: URI::MailTo::EMAIL_REGEXP }

  # allow_nil deixa atualizar o usuário sem trocar a senha; sem isso,
  # qualquer update passaria a exigir senha.
  validates :password, length: { minimum: 8 }, allow_nil: true
end
