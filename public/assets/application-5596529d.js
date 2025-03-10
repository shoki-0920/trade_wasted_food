// app/javascript/application.js

import Rails from "rails-ujs"
import * as ActiveStorage from "activestorage"
import { Turbo } from "@hotwired/turbo-rails"

// Turbo, Rails UJS, ActiveStorage を初期化する
Rails.start()
ActiveStorage.start()
Turbo.start()