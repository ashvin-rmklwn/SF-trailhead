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
trigger ContactTrigger on Contact (after insert) {
    ContactTriggerHandler handler = new ContactTriggerHandler();

    if(trigger.isAfter && trigger.isInsert){
        handler.handleAfterInsert(trigger.new);
    }
}