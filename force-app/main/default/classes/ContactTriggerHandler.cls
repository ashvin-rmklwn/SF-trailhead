/**
 * @description       : 
 * @author            : ARM
 * @group             : 
 * @last modified on  : 15-05-2023
 * @last modified by  : ARM
 * @Version           :  
 * Modifications Log
 * Ver   Date         Author   Modification
 * 1.0   15-05-2023   ARM   Initial Version
**/
public with sharing class ContactTriggerHandler {
    public ContactTriggerHandler() {

    }

     public void handleAfterInsert(List<Contact> lstNewContact){
       Id partnerId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Partner').getRecordTypeId();
       Map<id,contact> MapIdToCon = new Map<id,contact>();
       for(Contact c : lstNewContact){
        if(c.RecordTypeId == partnerId){
            MapIdToCon.put(c.Id, c);
        }
       }

       if(MapIdToCon.size() > 0){
        System.enqueueJob(new QUE01_CreateUser(MapIdToCon));
       }
     }
}