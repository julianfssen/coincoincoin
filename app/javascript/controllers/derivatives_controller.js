import Rails from "@rails/ujs"
import { Controller } from "stimulus"

export default class extends Controller {
	static targets = ['derivativeExchange']

	form() {
	}

	change() {
		const form = this.element.parentElement;
		form.submit();
	}
}
