// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "flowbite";
import "flowbite-datepicker";
import "./src/jquery";
import "apexcharts";

// // Reload Flowbite for Ruby on Rails at turbo
import { initFlowbite } from "flowbite";

addEventListener("turbo:before-stream-render", (event) => {
  const originalRender = event.detail.render;

  event.detail.render = function (streamElement) {
    originalRender(streamElement);
    initFlowbite();
  };
});
