Rails.configuration.stripe = {
  :publishable_key => 'pk_test_3ODGlBu89xjDT3uQizYeiyUU',
  :secret_key      => 'sk_test_tJERwH4SJdLGTDOyR349tse3'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
StripeEvent.signing_secret = 'whsec_oAQTGNOvtdmvrTkSzV3dFM70v83KvIg4'

StripeEvent.configure do |events|
  events.subscribe 'charge.succeeded', Webhooks::ChargeSucceeded.new
  events.subscribe 'charge.pending', Webhooks::ChargePending.new
  events.subscribe 'charge.failed', Webhooks::ChargeFailed.new
end
