/**
 * @description       : 
 * @author            : ARM
 * @group             : 
 * @last modified on  : 04-01-2023
 * @last modified by  : ARM
 * @Version           :  
 * Modifications Log
 * Ver   Date         Author   Modification
 * 1.0   04-01-2023   ARM   Initial Version
**/
import { LightningElement, wire } from "lwc";
import getAccountList from "@salesforce/apex/AccountController.getAccountList";

export default class WireApex extends LightningElement {
	accounts;
	error;

	@wire(getAccountList)
	wiredAccounts({ error, data }) {
		if (data) {
			this.accounts = data;
			this.error = undefined;
		} else if (error) {
			this.error = error;
			this.accounts = undefined;
		}
	}
}
