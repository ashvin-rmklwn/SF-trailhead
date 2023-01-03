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
public with sharing class AccountListControllerLwc {
	@AuraEnabled(cacheable=true)
	public static List<Account> queryAccountsByEmployeeNumber(Integer numberOfEmployees) {
		return [SELECT Name FROM Account WHERE NumberOfEmployees >= :numberOfEmployees];
	}

	@AuraEnabled
	public static List<Account> queryAccountsByRevenue(Decimal annualRevenue) {
		try {
			return [SELECT Name FROM Account WHERE AnnualRevenue >= :annualRevenue];
		} catch (Exception e) {
			throw new AuraHandledException(e.getMessage());
		}
	}
}
