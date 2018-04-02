Rails.configuration.stripe = {
  :publishable_key => 'pk_test_3ODGlBu89xjDT3uQizYeiyUU',
  :secret_key      => 'sk_test_tJERwH4SJdLGTDOyR349tse3'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]