// app/javascript/packs/application.js
import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import "toastr/build/toastr.min.css"

Rails.start();
Turbolinks.start();
ActiveStorage.start();
