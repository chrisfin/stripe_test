    	// Create a Stripe client.
		var stripe = Stripe('pk_test_3ODGlBu89xjDT3uQizYeiyUU');

		// Create an instance of Elements.
		var elements = stripe.elements();

		// Custom styling can be passed to options when creating an Element.
		// (Note that this demo uses a wider set of styles than the guide below.)
		var style = {
		  base: {
		    color: '#32325d',
		    lineHeight: '18px',
		    fontFamily: '"Helvetica Neue", Helvetica, sans-serif',
		    fontSmoothing: 'antialiased',
		    fontSize: '16px',
		    '::placeholder': {
		      color: '#aab7c4'
		    }
		  },
		  invalid: {
		    color: '#fa755a',
		    iconColor: '#fa755a'
		  }
		};

		
		// Create an instance of the card Element.
		var card = elements.create('card', {style: style});

		// Add an instance of the card Element into the `card-element` <div>.
		card.mount('#card-element');

		// Handle real-time validation errors from the card Element.
		card.addEventListener('change', function(event) {
		  var displayError = document.getElementById('card-errors');
		  if (event.error) {
		    displayError.textContent = event.error.message;
		  } else {
		    displayError.textContent = '';
		  }
		});

		// Handle form submission.
		var form = document.getElementById('payment-form');
		
		form.addEventListener('submit', function(event) {
		  event.preventDefault();

		var name = form.querySelector('input[name="cardholder-name"]').value;
		var address = form.querySelector('input[name="address"]').value;
		var city = form.querySelector('input[name="city"]').value;

		var ownerInfo = {
		  owner: {
		    name: name,
		    address: {
		      line1: address,
		      city: city,
		      country: 'US',
		    },
		  },
		};

		  stripe.createSource(card, ownerInfo).then(function(result) {
		    if (result.error) {
	      		// Inform the user if there was an error
			    var errorElement = document.getElementById('card-errors');
			    errorElement.textContent = result.error.message;
		    } else {
		      	// Send the source to your server
      			stripeSourceHandler(result.source);
		    }
		  });
		});

		function stripeSourceHandler(source) {
		  // Insert the source ID into the form so it gets submitted to the server
		  var form = document.getElementById('payment-form');
		  var hiddenInput = document.createElement('input');
		  hiddenInput.setAttribute('type', 'hidden');
		  hiddenInput.setAttribute('name', 'stripeSource');
		  hiddenInput.setAttribute('value', source.id);
		  form.appendChild(hiddenInput);

		  // Submit the form
		  form.submit();
		}
