/**
 * @description       :
 * @author            : ARM
 * @group             :
 * @last modified on  : 03-01-2023
 * @last modified by  : ARM
 * @Version           :
 * Modifications Log
 * Ver   Date         Author   Modification
 * 1.0   03-01-2023   ARM   Initial Version
 **/
import { LightningElement, wire } from "lwc";
import queryAccountsByRevenue from "@salesforce/apex/AccountListControllerLwc.queryAccountsByRevenue";
export default class AccountFinder extends LightningElement {
	annualRevenue = null;

	handleChange(event) {
		this.annualRevenue = event.detail.value;
	}
	reset() {
		this.annualRevenue = null;
	}
	@wire(queryAccountsByRevenue, { annualRevenue: "$annualRevenue" }) accounts;
}