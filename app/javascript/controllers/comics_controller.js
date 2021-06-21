import { Controller } from "stimulus"

export default class extends Controller {
  static values = { url: String }
  static targets = [ "query", "list" ]

  connect() {
    this.listComics()
  }

  search(event) {
    event.preventDefault()

    this.listComics()
  }

  listComics() {
    fetch(`${this.urlValue}?query=${this.queryTarget.value}`)
      .then(response => response.text())
      .then(html => this.listTarget.innerHTML = html)
  }
}
