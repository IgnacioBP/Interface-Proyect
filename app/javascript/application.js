// Entry point for the build script in your package.json
import "@hotwired/turbo-rails";
import "./controllers"; // Asegúrate de que esto esté importando los controladores correctamente
import * as bootstrap from "bootstrap";
import "@rails/ujs"
Rails.start();

// Si necesitas registrar controladores de Stimulus
import { Application } from "stimulus";
import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers";

// Inicializa Stimulus
const application = Application.start();

// Carga automáticamente los controladores en el directorio "controllers"
const context = require.context("./controllers", true, /\.js$/);
application.load(definitionsFromContext(context));
