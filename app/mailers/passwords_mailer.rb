class PasswordsMailer < ApplicationMailer
  def reset(user)
    @user = user
    mail subject: "Recuperação de senha", to: user.email_address
  end
end
