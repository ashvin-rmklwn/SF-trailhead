/**
 * @description       : 
 * @author            : ARM
 * @group             : 
 * @last modified on  : 15-05-2023
 * @last modified by  : ARM
 * @Version           :  
 * Modifications Log
 * Ver   Date         Author   Modification
 * 1.0   14-05-2023   ARM   Initial Version
**/
public with sharing class QUE01_CreateUser implements Queueable {
    Map<id,contact> mapContact = new Map<id,contact>();
    List<User> lstUser = new List<User> ();
    List<User> lstUserToInsert = new List<User> ();
    List<User> lstUserRemaining = new List<User> ();
    List<Id> lstUserInserted = new List<Id>();
    Map<String, Id> mapGroupToId = new Map<String, Id>();
    List<GroupMember > lstGroupM = new List<GroupMember >();
    List<ErrorLog__c> lstErrorLog = new List<ErrorLog__c>();


    public QUE01_CreateUser( Map<id,contact> mapConInsrted  ) {
        this.mapContact = mapConInsrted;
    }
    public QUE01_CreateUser(List<User> lstUserRmng  ) {
        this.lstUser = lstUserRmng;
    }

    public void execute(QueueableContext context) {
			try {
                Id profileId = [SELECT Id FROM Profile WHERE name = 'Customer Community User']?.Id;
                for(contact con : mapContact.values()){
                    lstUser.add(new User(
                                            Email = con.Email,
                                            ProfileId = profileId,
                                            UserName = con.FirstName + '.' + con.LastName + '@companyx.com',
                                            Alias = 'com',
                                            TimeZoneSidKey = 'America/New_York',
                                            EmailEncodingKey = 'ISO-8859-1',
                                            LocaleSidKey = 'en_US',
                                            LanguageLocaleKey = 'en_US',
                                            ContactId = con.Id,
                                            FirstName = con.FirstName,
                                            LastName = con.LastName,
                                            TECH_PartnerExtId__c = con.Id
                                        ) );
                }

                if (lstUser.size() > 0) {
					for (Integer i = 0; i < lstUser.size(); i++) {
						if (i < 5000) {
							lstUserToInsert.add(lstUser[i]);
						} else {
							lstUserRemaining.add(lstUser[i]);
						}
					}
					
				}
        
                if(lstUserToInsert.size() > 0){

                    for(Group g : [SELECT Id, DeveloperName from group WHERE DeveloperName IN ('Managers', 'Agent', 'CEO')]){
                        mapGroupToId.put(g.DeveloperName, g.Id);
                    }

                    list<Database.SaveResult> resultsCon = Database.insert(lstUserToInsert, false);

                    for (Integer i = 0; i < lstUserToInsert.size(); i++) {
                        Database.SaveResult sr = resultsCon[i];

                        if (!sr.isSuccess()) {
                            ErrorLog__c eL = new ErrorLog__c(
                                ClassName__C = 'QUE01_CreateUser',
                                RecordId__c = lstUserToInsert[i].Id,
                                Message__c = sr.getErrors().get(0).getMessage()
                            );  

                             lstErrorLog.add(eL);
                        }else{
                            lstUserInserted.add(lstUserToInsert[i].Id);
                            String jTitle = mapContact.get(lstUserToInsert[i].ContactId)?.JobTitle__c;
                            lstGroupM.add(new GroupMember(UserOrGroupId = lstUserToInsert[i].Id, groupId = mapGroupToId.get(jTitle)));
                        }
                    }
                        
                }

                if(lstGroupM.size() > 0){
                    list<Database.SaveResult> resultsCon = Database.insert(lstGroupM, false);

                    for (Integer i = 0; i < lstGroupM.size(); i++) {
                        Database.SaveResult sr = resultsCon[i];

                        if (!sr.isSuccess()) {
                            ErrorLog__c eL = new ErrorLog__c(
                                ClassName__C = 'QUE01_CreateUser',
                                RecordId__c = lstGroupM[i].Id,
                                Message__c = sr.getErrors().get(0).getMessage()
                            );  

                             lstErrorLog.add(eL);
                        }
                    }
                }

                if(lstUserInserted.size() > 0 || lstErrorLog.size() > 0){
                   System.enqueueJob(new QUE02_ManageCreationOfUser(lstUserInserted, lstErrorLog));
                }
                if(lstUserRemaining.size() >0){
                    System.enqueueJob(new QUE01_CreateUser(lstUserRemaining));
                }
			
			} catch (Exception e) {
				
                insert new ErrorLog__c(
                                ClassName__C = 'QUE01_CreateUser',
                                Message__c = e.getMessage()
                );  
			}
    }
    
}