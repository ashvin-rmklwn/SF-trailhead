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
import { LightningElement } from "lwc";
import Contact_OBJECT from "@salesforce/schema/Contact";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import FirstName from "@salesforce/schema/Contact.FirstName";
import LastName from "@salesforce/schema/Contact.LastName";
import Email from "@salesforce/schema/Contact.Email";
export default class ContactCreator extends LightningElement {
  objectApiName = Contact_OBJECT;
  fields = [FirstName, LastName, Email];

  handleSuccess(event) {
    const toastEvent = new ShowToastEvent({
      title: "Contact created",
      message: "Record ID: " + event.detail.id,
      variant: "success"
    });
    this.dispatchEvent(toastEvent);
  }
}