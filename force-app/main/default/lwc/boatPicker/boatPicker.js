/**
 * @description       : 
 * @author            : ARM
 * @group             : 
 * @last modified on  : 04-06-2025
 * @last modified by  : ARM
**/
import { LightningElement, wire , api} from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';

import BOAT_PICTURE_FIELD from "@salesforce/schema/Boat__c.Picture__c";
import BOAT_NAME_FIELD from "@salesforce/schema/Boat__c.Name";
import BOAT_OWNER_FIELD from "@salesforce/schema/Boat__c.Contact__r.Name";
import BOAT_PRICE_FIELD from "@salesforce/schema/Boat__c.Price__c";
import BOAT_TYPE_FIELD from "@salesforce/schema/Boat__c.BoatType__r.Name";

const BOAT_FIELDS = [BOAT_PICTURE_FIELD, BOAT_NAME_FIELD,BOAT_OWNER_FIELD, BOAT_PRICE_FIELD, BOAT_TYPE_FIELD];

export default class Boats extends LightningElement {
    
    
    boatId;
    @api height;

    get showBoat() {
        return this.boatId != null;
    }

    @wire(getRecord, { recordId: '$boatId', fields: BOAT_FIELDS  })
    boatDetail;

    // BEGIN GETTERS FOR BOAT FIELDS
    get boatPicture() {
        return getFieldValue(this.boatDetail.data, BOAT_PICTURE_FIELD);
    }
    get boatName() {
        return getFieldValue(this.boatDetail.data, BOAT_NAME_FIELD);
    }
    get boatOwner() {
        return getFieldValue(this.boatDetail.data, BOAT_OWNER_FIELD);
    }
    get boatPrice() {
        return getFieldValue(this.boatDetail.data, BOAT_PRICE_FIELD);
    }
    get boatType() {
        return getFieldValue(this.boatDetail.data, BOAT_TYPE_FIELD);
    }
    // END GETTERS FOR BOAT FIELDS

    get backgroundStyle() {
        if (!this.showBoat) {
            return '';
        } else {
            return `background-image:url('${this.boatPicture}')`;
        }
    }

    displayInfo = {
        primaryField: 'Name',
        additionalFields: ['BoatType__r.Name'],
    };

    matchingInfo = {
        primaryField: { fieldPath: 'Name', mode: 'startsWith' },
        additionalFields: [{ fieldPath: 'BoatType__r.Name' }],
    };
    handleChange(event) {
        // Update the boatId when the selected record changes
        console.log('Boat Id: ', event.detail.recordId);
        this.boatId = event.detail.recordId;
        console.log('##Boat Id: ', this.boatId);
    }

}