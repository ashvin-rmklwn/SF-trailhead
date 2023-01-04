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
import { CurrentPageReference } from "lightning/navigation";

export default class WireCPR extends LightningElement {
	@wire(CurrentPageReference) pageRef;

	get currentPageRef() {
		return this.pageRef ? JSON.stringify(this.pageRef, null, 2) : "";
	}
}
