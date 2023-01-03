/**
 * @description       : 
 * @author            : ARM
 * @group             : 
 * @last modified on  : 03-01-2023
 * @last modified by  : ARM
 * @Version           :  
 * Modifications Log
 * Ver   Date         Author   Modification
 * 1.0   01-02-2023   ARM   Initial Version
**/
import { LightningElement, wire } from "lwc";
import queryAccountsByEmployeeNumber from "@salesforce/apex/AccountListControllerLwc.queryAccountsByEmployeeNumber";
export default class AccountSearch extends LightningElement {
  numberOfEmployees = null;
  handleChange(event) {
    this.numberOfEmployees = event.detail.value;
  }
  reset() {
    this.numberOfEmployees = null;
  }
  @wire(queryAccountsByEmployeeNumber, {
    numberOfEmployees: "$numberOfEmployees"
  })
  accounts;
}