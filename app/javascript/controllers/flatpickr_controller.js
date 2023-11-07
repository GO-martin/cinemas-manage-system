import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";
// Connects to data-controller="flatpickr"
export default class extends Controller {
  connect() {
    flatpickr(".start_time", {
      enableTime: true,
      // human friendly date with time (EG: April 24, 2021 12:00 PM)
      dateFormat: "F j, Y h:i K",
    });

    flatpickr(".release_date", {});

    flatpickr(".birthday", {});
  }
}
