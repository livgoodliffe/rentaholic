export default () => {
  let opacity = 1

  const flashAlerts = document.querySelectorAll('.alert')

  console.log(flashAlerts)

  const setIntervalLimited = (callback, interval, x) => {
    for (var i = 0; i < x; i++) {
      setTimeout(callback, i * interval);
    }
  }

  // setIntervalLimited(function() {
  //   console.log('hit');
  // }, 1000, 10)

  const opacity_reducer = () => {
    console.log('opacity reducer')
    console.log(flashAlerts)
    flashAlerts.forEach((alert) => {
      console.log(alert.style.opacity);
      let opacity = ""
      if (alert.style.opacity === "") opacity = "1"
      else {
        opacity = alert.style.opacity;
      }
      console.log(parseInt(opacity))
      const newOpacity = parseFloat(opacity) - 0.125;
      alert.style.opacity = `${newOpacity}`;
      if (newOpacity === 0) {
        alert.querySelector('button').click() // dismiss alert once faded
      }
    })
  }

  setTimeout(() => { setIntervalLimited(opacity_reducer, 250, 8) }, 3000);

}
