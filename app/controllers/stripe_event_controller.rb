class StripeEventController < ApplicationController
	skip_before_action :verify_authenticity_token, only: :create

	def create
	    event = Stripe::Event.retrieve(params[:id])
	    # do something with charge success event
	    head :ok
  	rescue Stripe::APIConnectionError, Stripe::StripeError
    	head :not_found
  	end
end
