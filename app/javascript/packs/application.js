import "bootstrap";

import booking_form from 'booking_form';

const modal_button = document.getElementById('modal_button')

if (modal_button !== null) {
  modal_button.addEventListener('click', () => {
    // setTimeout(() => { booking_form() }, 1500);
    booking_form();
  })
}
