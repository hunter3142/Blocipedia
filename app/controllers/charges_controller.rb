class ChargesController < ApplicationController
  def create
    # Amount in cents
    @amount = 1500

  	# Creates a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
 
    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: @amount,
      description: "Premium Membership - #{current_user.email}",
      currency: 'usd'
    )

    current_user.update_attribute(:role, 'premium')
 
    flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
    redirect_to wikis_path # or wherever
 
    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to wikis_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership - #{current_user.email}",
      amount: @amount
    }
  end

  def downgrade_to_standard
    if current_user.premium? && current_user.standard!
      current_user.wikis.where(private: true).update_all(private: false)
      flash[:notice] = "Your account has been downgraded"
    else
      flash[:notice] = "You aren't allowed to do that."
    end
    redirect_to :back
  end
end
