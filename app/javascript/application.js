import "@hotwired/turbo-rails";
import Rails from "@rails/ujs";
import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"
import "custom/map"

Rails.start(); 

const application = Application.start();
const context = require.context("controllers", true, /\.js$/);
application.load(definitionsFromContext(context));

document.addEventListener("turbo:load", () => {
  console.log("Turbo loaded!");
});