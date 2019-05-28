export default () => {
  let opacity = 1

  const flashAlerts = document.querySelectorAll('.alert')

  const setIntervalLimited = (callback, interval, x) => {
    for (var i = 0; i < x; i++) {
      setTimeout(callback, i * interval);
    }
  }

  const opacity_reducer = () => {
    flashAlerts.forEach((alert) => {
      let opacity = ""
      if (alert.style.opacity === "") opacity = "1"
      else {
        opacity = alert.style.opacity;
      }
      const newOpacity = parseFloat(opacity) - 0.125;
      alert.style.opacity = `${newOpacity}`;
      if (newOpacity === 0) {
        alert.querySelector('button').click() // dismiss alert once faded
      }
    })
  }

  setTimeout(() => { setIntervalLimited(opacity_reducer, 250, 8) }, 3000);

}
