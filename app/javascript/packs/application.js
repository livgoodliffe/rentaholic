import "bootstrap";

import booking_form from 'booking_form';

const body = document.querySelector('body');

const backWithBackspace = (event) => {
  event.preventDefault();
  if (event.keyCode === 8) {
    window.history.back();
  }
}

body.addEventListener('keyup', backWithBackspace);


const modal_button = document.getElementById('modal_button')

if (modal_button !== null) {
  modal_button.addEventListener('click', () => {
    booking_form();
  })
}
