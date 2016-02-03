class PartnerMailer < ApplicationMailer
  default from: "youremail@email.com"

  def confirm_partner(user, partner)
    set_headers(user)

    @user = user
    @partner = partner

    mail(to: partner.email, subject: "Confirm your partner!")
  end

  def new_partner(user, partner_email)
    set_headers(user)
    @user = user
    @partner_email = partner_email

    mail(to: partner_email, subject: "You have been invited to join!")
  end


  def set_headers(user)
    headers["Message-ID"] = "<partners/#{user.id}@your-app-name.example>"
    headers["In-Reply-To"] = "<partners/#{user.id}@your-app-name.example>"
    headers["References"] = "<partners/#{user.id}@your-app-name.example>"
  end
end
