# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin 'flowbite', to: 'https://ga.jspm.io/npm:flowbite@1.8.1/lib/esm/index.js'
pin '@popperjs/core', to: 'https://ga.jspm.io/npm:@popperjs/core@2.11.8/lib/index.js'
pin 'flowbite-datepicker', to: 'https://ga.jspm.io/npm:flowbite-datepicker@1.2.2/js/main.js'
pin 'dropzone', to: 'https://ga.jspm.io/npm:dropzone@6.0.0-beta.2/dist/dropzone.mjs'
pin 'just-extend', to: 'https://ga.jspm.io/npm:just-extend@5.1.1/index.esm.js'
pin '@rails/activestorage', to: 'https://ga.jspm.io/npm:@rails/activestorage@7.1.0/app/assets/javascripts/activestorage.esm.js'
pin 'jquery', to: 'https://ga.jspm.io/npm:jquery@3.7.1/dist/jquery.js'
pin 'flatpickr', to: 'https://ga.jspm.io/npm:flatpickr@4.6.13/dist/esm/index.js'
pin 'apexcharts', to: 'https://ga.jspm.io/npm:apexcharts@3.44.0/dist/apexcharts.common.js'
pin_all_from 'app/javascript/src', under: 'src', to: 'src'
pin_all_from 'app/javascript/helpers', under: 'helpers', to: 'helpers'
