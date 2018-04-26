public class SoftCreditMapper {
    // get the merged stream and turn it into aura enabled softies
    public SoftCreditMapper() {
        throw new SingletonException('Cannot instantiate SoftCreditMapper');
    }
    
    public static SoftCredit go(SoftCreditRepository.Result result) {
        SoftCredit retVal = new SoftCredit();
		retVal.total_records = result.creditObjects.size();
        retVal.soft_credits = new List<SoftCredit.Item>();
        for(SoftCreditRepository.CreditObject obj : result.creditObjects) {
            SoftCredit.Item item = new SoftCredit.Item();
            
            item.contact_id = result.contactId;
            if (obj.SObjectType == npsp__Partial_Soft_Credit__c.SObjectType) {
                item.psc_id = (Id)obj.get('Id');
                item.ocr_id = (Id)obj.get('npsp__Contact_Role_ID__c');
                item.oppty_id = (Id)obj.get('npsp__Opportunity__c');
                item.role = (String)obj.get('npsp__Role_Name__c');
                item.amount = (Decimal)obj.get('npsp__Amount__c');
                item.partial = True;
            } else {
                item.ocr_id = (Id)obj.get('Id');
                item.role = (String)obj.get('Role');
                item.oppty_id = (Id)obj.get('OpportunityId');
                item.amount = (Decimal)obj.getSObject('Opportunity').get('Amount');
                item.partial = False;
            }
            item.oppty_name = (String)result.opportunities.get(item.oppty_id).get('Name');
            item.opportunity_date = (Date)result.opportunities.get(item.oppty_id).get('CloseDate');

            
            retVal.soft_credits.add(item);
        }
        return retVal;
    }
}