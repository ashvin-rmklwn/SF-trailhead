/**
 * @description       : 
 * @author            : ARM
 * @group             : 
 * @last modified on  : 01-15-2026
 * @last modified by  : ARM
**/
import { LightningElement, api } from "lwc";

export default class extends LightningElement {
  @api objectApiName;

  get computedClassNames() {
    return [
      "slds-box",
      "slds-theme_alert-texture",
      this.objectApiName === 'Account' ? "slds-theme_shade" : "slds-theme_success"
    ];
  }
}