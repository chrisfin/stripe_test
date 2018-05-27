
// Assumes you've already included Stripe.js! 
var myForm = document.querySelector('.my-form');
myForm.addEventListener('submit', handleForm);

async function handleForm(event) {
  event.preventDefault();

  var stripe = Stripe('pk_test_3ODGlBu89xjDT3uQizYeiyUU');
  
  var account_token = await stripe.createToken('account', {
    legal_entity: {
      first_name: document.querySelector('.inp-first-name').value,
      last_name: document.querySelector('.inp-last-name').value,
      address: {
        line1: document.querySelector('.inp-street-address1').value,
        city: document.querySelector('.inp-city').value,
        state: document.querySelector('.inp-state').value,
        postal_code: document.querySelector('.inp-zip').value,
      },
    },
    tos_shown_and_accepted: true,
  });

  if (account_token.token) {
    document.querySelector('#accountToken').value = account_token.token.id;
    myForm.submit();
  }
}