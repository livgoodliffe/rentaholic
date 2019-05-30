import 'bootstrap';

import bookingForm from '../booking_form';
import reviewForm from '../review_form';
import flashFadeOut from '../flash_fade_out';
import footer from '../footer';
import select2setup from '../select2_setup';

import 'mapbox-gl/dist/mapbox-gl.css';

import { initMapbox } from '../plugins/init_mapbox';

bookingForm();
reviewForm();
flashFadeOut();
footer();
select2setup();

initMapbox();
