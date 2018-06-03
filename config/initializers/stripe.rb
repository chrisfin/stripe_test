Rails.configuration.stripe = {
  :publishable_key => 'pk_test_3ODGlBu89xjDT3uQizYeiyUU',
  :secret_key      => 'sk_test_tJERwH4SJdLGTDOyR349tse3'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]

StripeEvent.signing_secrets = [
  Rails.application.secrets.stripe_account_signing_secret = 'whsec_oAQTGNOvtdmvrTkSzV3dFM70v83KvIg4',
  Rails.application.secrets.stripe_connect_signing_secret = 'whsec_KWbiyMI41KDSPBWrmEzuWUvXOxgH7awO',
]

StripeEvent.configure do |events|
  events.subscribe 'charge.succeeded', Webhooks::ChargeSucceeded.new
  events.subscribe 'charge.pending', Webhooks::ChargePending.new
  events.subscribe 'charge.failed', Webhooks::ChargeFailed.new
  events.subscribe 'account.updated', Webhooks::AccountUpdated.new
  events.subscribe 'account.external_account.created', Webhooks::AccountExternalAccountCreated.new
  events.subscribe 'account.external_account.updated', Webhooks::AccountExternalAccountUpdated.new
end
