import "bootstrap";

const body = document.querySelector('body');

const backWithBackspace = (event) => {
  event.preventDefault();
  console.log(event.keyCode)
  if (event.keyCode === 8) {
    window.history.back();
  }
}

body.addEventListener('keyup', backWithBackspace);
