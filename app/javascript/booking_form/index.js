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

  const amount = ((end_date - start_date) / (24 * 60 * 60 * 1000)) * daily_rate;

  if (amount > 0 && start_date >= today) {
    total_amount.innerText = amount;
  } else {
    if (amount == 0 && start_date >= today) {
      total_amount.innerText = "";
    } else {
      total_amount.innerText = " Invalid Date(s) Selected";
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

export default setupListeners;
