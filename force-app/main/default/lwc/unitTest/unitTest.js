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
import { LightningElement, api } from "lwc";
import { sum } from "./sum";

export default class UnitTest extends LightningElement {
  @api unitNumber = sum(2, 3);
  handleChange(event) {
    this.unitNumber = event.target.value;
  }
}
