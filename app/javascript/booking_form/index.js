const recalculate = () => {
  const y = document.getElementById("booking_start_date_1i").value;
  const m = document.getElementById("booking_start_date_2i").value;
  const d = document.getElementById("booking_start_date_3i").value;

  const y2 = document.getElementById("booking_end_date_1i").value;
  const m2 = document.getElementById("booking_end_date_2i").value;
  const d2 = document.getElementById("booking_end_date_3i").value;

  const daily_rate = document.getElementById("daily_rate").innerText;
  const total_amount = document.getElementById("total_amount");

  const start_date = new Date(y, m - 1, d)
  const end_date = new Date(y2, m2 - 1, d2);

  const today = new Date().setHours(0, 0, 0, 0);
  const days = Math.ceil(((end_date - start_date) / (24 * 60 * 60 * 1000)))
  const amount = days * daily_rate;

  const submit_button = document.querySelector('.booking-submit input');

  if (amount > 0 && start_date >= today) {
    total_amount.innerText = `${amount}. ${days} day(s)`;
    console.log('valid')
    submit_button.disabled = false;
  } else {
    console.log('invalid')
    submit_button.disabled = true;

    if (amount == 0 && start_date >= today) {
      total_amount.innerText = "0 - Booking must be for at least 1 day";
    } else {
      total_amount.innerText = "n/a - Invalid Date(s) Selected";
    }
  }
}

const setupListeners = () => {

  const selects = document.querySelectorAll('#new_booking select');

  selects.forEach((elem) => {
    console.log('listener setup')
    elem.addEventListener('change', () => {
      recalculate()
    })
  })
}

export default () => {
  const modal_button = document.getElementById('modal_button')
  if (modal_button !== null) {
    modal_button.addEventListener('click', () => {
      setupListeners();
    })
  }
}
