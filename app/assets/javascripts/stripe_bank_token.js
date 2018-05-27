// Assumes you've already included Stripe.js! 
var myForm = document.querySelector('.my-form');
myForm.addEventListener('submit', handleForm);

async function handleForm(event) {
  event.preventDefault();

  var stripe = Stripe('pk_test_3ODGlBu89xjDT3uQizYeiyUU');  

  var bank_token = await stripe.createToken('bank_account', {
      country: "US",
      currency: "usd",
      account_holder_name: "Chris Finlayson",
      bank_name: document.querySelector('.inp-bank-account').value,
      last4: document.querySelector('.inp-last4').value,
      routing_number: document.querySelector('.inp-routing-number').value,
      account_number: document.querySelector('.inp-account-number').value,
    });

  if (bank_token.token) {
    document.querySelector('#bankToken').value = bank_token.token.id;
    myForm.submit();
  }
}