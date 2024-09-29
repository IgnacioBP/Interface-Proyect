import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "sidebar", "mainSidebar" ]

  connect() {
    console.log("Sidebar controller connected")
  }

  toggle() {
    console.log("Toggle pressed")
    this.sidebarTarget.classList.toggle('collapsed')
    this.mainSidebarTarget.classList.toggle('collapsed')
  }
}