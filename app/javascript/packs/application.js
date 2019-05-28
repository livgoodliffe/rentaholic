import "bootstrap";

import booking_form from 'booking_form';
import flash_fade_out from 'flash_fade_out';

const body = document.querySelector('body');

const backWithBackspace = (event) => {
  event.preventDefault();
  if (event.keyCode === 8) {
    window.history.back();
  }
}

body.addEventListener('keyup', backWithBackspace);

booking_form();
flash_fade_out();
