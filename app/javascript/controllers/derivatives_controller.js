import { Controller } from "stimulus"

export default class extends Controller {
	static targets = ['derivativeExchange']

	change() {
		console.log('Element: ', this.element);
		console.log('Element Value: ', this.element.value);
		console.log('Element: ', this.derivativeExchangeTarget);
	}
}
