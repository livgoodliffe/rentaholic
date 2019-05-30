import $ from 'jquery';
import 'select2';
import 'select2/dist/css/select2.css';

// initialise select2 controls
export default () => {
  if (document.getElementById('item_category')) {
    $('#item_category').select2({
      // placeholder: 'Choose category',
      allowClear: false,
    });
  }
};
