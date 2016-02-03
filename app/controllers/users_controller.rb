class UsersController < ApplicationController
  def confirm_partner
    @user = User.find(params[:user_id])
    @partner = User.find(params[:id])

    if @user.partner_email == @partner.email
      #@partner.approve_partner
      flash[:notice] = "Your partnership has been confirmed!"
    else
      @partner.partner_email = nil
      flash[:error] = "I'm sorry, we couldn't approve your partnership at this time."
    end
  end
end
