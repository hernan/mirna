import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "form", "data" ];

    edit(event) {
        event.preventDefault();
        event.target.style.display = "none";
        this.formTarget.style.display = "block";
    }

    cancel(event) {
        event.preventDefault();
        this.formTarget.style.display = "none";
        this.dataTarget.style.display = "block";
    }

    close(event) {
        if (event.keyCode === 27) {
            this.cancel(event);
        }
    }
}
