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
public with sharing class AccountController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        throw new AuraHandledException('Forced error');
        // return [
        //     SELECT Name, AnnualRevenue, Industry
        //     FROM Account
        //     WITH SECURITY_ENFORCED
        //     ORDER BY Name
        // ];
    }
}