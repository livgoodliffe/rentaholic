export default () => {
  const element = document.querySelector('.grid-month');
  if (element) {
    const { offset } = element.dataset;
    for (let x = 0; x < offset; x += 1) {
      element.insertAdjacentHTML('afterbegin', '<div class="month-day d-flex justify-content-center align-items-center"></div>');
    }
  }
};
