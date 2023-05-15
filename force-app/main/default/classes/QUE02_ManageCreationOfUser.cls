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
public with sharing class QUE02_ManageCreationOfUser implements Queueable{
    Map<String, Id> mapGroupToId = new Map<String, Id>();
    List<GroupMember > lstGroupM = new List<GroupMember >();
    List<Task> lstTaskInsrt = new List<Task>();
    List<Id> lstUserIdUse = new List<Id>();
    List<ErrorLog__c> lstErrorLog = new List<ErrorLog__c>();

     public QUE02_ManageCreationOfUser(List<Id> lstUserId, List<ErrorLog__c> lstErrLog) {
        this.lstUserIdUse= lstUserId;
        this.lstErrorLog = lstErrLog;
    }

    public void execute(QueueableContext context) {
        try{
            
            for(Id usrId : lstUserIdUse){
                
                lstTaskInsrt.add(new Task(OwnerId = usrId,Priority='Normal' , Subject = 'Call', Type = 'Call'));
                
            }

            if(lstTaskInsrt.size() > 0){
                list<Database.SaveResult> resultsCon = Database.insert(lstTaskInsrt, false);

                for (Integer i = 0; i < lstTaskInsrt.size(); i++) {
                    Database.SaveResult sr = resultsCon[i];

                    if (!sr.isSuccess()) {
                        ErrorLog__c eL = new ErrorLog__c(
                            ClassName__C = 'QUE02_ManageCreationOfUser',
                            RecordId__c = lstTaskInsrt[i].Id,
                            Message__c = sr.getErrors().get(0).getMessage()
                        );  

                            lstErrorLog.add(eL);
                    }
                }    
            }

            if(lstErrorLog.size() > 0 ){
                insert lstErrorLog;
            }
            

        }catch(Exception e){
            insert new ErrorLog__c(
                                ClassName__C = 'QUE02_ManageCreationOfUser',
                                Message__c = e.getMessage()
            );  
        }
    }
}