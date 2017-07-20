class UserMailer < ApplicationMailer
  def sample_email(sender, reciever)
    @sender = sender
    @user = reciever
    mail(from: @sender.email, to: @user.email, subject: 'regards')
  end
end
