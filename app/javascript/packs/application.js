// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "@gouvfr/dsfr/dist/js/dsfr.module"
import "@gouvfr/dsfr/dist/css/dsfr.css"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener('animationend', evt => {
    const elem = evt.target
    for (let i = 0; i < elem.classList.length; i++) {
        if (elem.classList[i] == "fr-alert") {
            elem.classList.add("fr-alert--hidden")
        }
    }
})