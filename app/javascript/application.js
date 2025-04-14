import "@hotwired/turbo-rails";
import Rails from "@rails/ujs";
import "custom/map"

Rails.start(); 

document.addEventListener("turbo:load", () => {
  console.log("Turbo loaded!");
});