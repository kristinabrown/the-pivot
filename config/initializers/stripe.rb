Rails.configuration.stripe = {
 #for deploy set ENV with: export PUBLISHABLE_KEY=api & export SECRET_KEY=api 
 # :publishable_key => ENV['PUBLISHABLE_KEY'],
 # :secret_key      => ENV['SECRET_KEY']
 #test 
 :publishable_key => "pk_test_3xwU9CS65VdaNqahQEsSxN1v",
 :secret_key      => "sk_test_ZRDV3H9NLlO184tA8CJky8hL"
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]