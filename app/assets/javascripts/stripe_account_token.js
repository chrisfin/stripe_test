
const stripe = Stripe('pk_test_3ODGlBu89xjDT3uQizYeiyUU');
const Form = document.querySelector('account-save');
Form.addEventListener('submit', handleForm);

async function handleForm(event) {
  event.preventDefault();

  const account = await stripe.createToken('account', {
    legal_entity: {
      address: {
        line1: document.querySelector('.inp-street-address1').value,
        city: document.querySelector('.inp-city').value,
        state: document.querySelector('.inp-state').value,
        postal_code: document.querySelector('.inp-zip').value,
      }, 
    },
  });

  const bank_account = await stripe.createToken('bank_account', {
    currency: "usd",
    bank_name: document.querySelector('.inp-bank-account').value,
    last4: document.querySelector('.inp-last4').value,
    routing_number: document.querySelector('.inp-routing-number').value,
    account_number: document.querySelector('.inp-account-number').value,
  });

    document.querySelector('#account_token').value = account.token.id;
    document.querySelector('#bank_account_token').value = "10";
    Form.submit();

}