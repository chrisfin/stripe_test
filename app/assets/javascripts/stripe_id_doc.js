 	const myForm = document.querySelector('.my-form');
	myForm.addEventListener('submit', handleForm);

	async function handleForm(event) {
  		event.preventDefault();

  	var stripe = Stripe('pk_test_3ODGlBu89xjDT3uQizYeiyUU');  

	const data = new FormData();
	data.append('file', 'https://stripe.com/img/docs/connect/success.png');
	data.append('purpose', 'identity_document');
	const fileResult = await fetch('https://uploads.stripe.com/v1/files', {
	  method: 'POST',
	  headers: {'Authorization': `Bearer ${stripe._apiKey}`},
	  body: data,
	});
	const fileData = await fileResult.json();


	//const result = await stripe.cr	eateToken('account', {
	  //legal_entity: {
	    //first_name: document.querySelector('.inp-first-name').value,
	    //last_name: document.querySelector('.inp-last-name').value,
	    //address: {
	      //line1: document.querySelector('.inp-street-address1').value,
	      //city: document.querySelector('.inp-city').value,
	      //state: document.querySelector('.inp-state').value,
	      //postal_code: document.querySelector('.inp-zip').value,
	    //},
	    //verification: {
	      //document: fileData.id,
	    //},
	  //},
	  //tos_shown_and_accepted: true,
	//});

	document.querySelector('#idToken').value = "Hello";
	myForm.submit();
}