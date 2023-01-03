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
public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts() {
         throw new AuraHandledException('Forced error');
        // return [
        //     SELECT FirstName, LastName, Email
        //     FROM Contact
        //     WITH SECURITY_ENFORCED
        //     ORDER BY LastName
        // ];
    }
}