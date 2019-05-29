import "bootstrap";

import booking_form from 'booking_form';
import flash_fade_out from 'flash_fade_out';
import 'mapbox-gl/dist/mapbox-gl.css';

import { initMapbox } from '../plugins/init_mapbox';

booking_form();
flash_fade_out();

initMapbox();
