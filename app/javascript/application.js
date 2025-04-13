import "@hotwired/turbo-rails";
import Rails from "@rails/ujs";

Rails.start(); // ← これを追加する！

document.addEventListener("turbo:load", () => {
  console.log("Turbo loaded!");
});