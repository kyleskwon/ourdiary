class ChargesController < ApplicationController
  def create

   # Creates a Stripe Customer object, for associating
   # with the charge
   customer = Stripe::Customer.create(
     email: current_user.email,
     card: params[:stripeToken]
   )

   # Where the real magic happens
   charge = Stripe::Charge.create(
     customer: customer.id, # Note -- this is NOT the user_id in your app
     amount: Amount.default,
     description: "Premium Membership - #{current_user.email}",
     currency: 'usd'
   )

   current_user.premium!

   flash[:notice] = "Thank you #{current_user.email}! You are now a Premium Member!"
   redirect_to homebase_index_path(current_user) # or wherever

 # Stripe will send back CardErrors, with friendly messages
 # when something goes wrong.
 # This `rescue block` catches and displays those errors.
 rescue Stripe::CardError => e
   flash.now[:alert] = e.message
   redirect_to new_charge_path
 end

 def new
     @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership",
      amount: Amount.default
     }
   end

   def downgrade
     current_user.member!
     flash[:notice] = "No problem, we're glad you're still a member!"
     redirect_to :back
   end
 end

 class Amount
   def self.default
     2_00
   end
 end
