public class SoftCreditRepository {
    // find the appropriate soft credits and merge the streams
    
    public Id contactId {get;set;}
    
    public SoftCreditRepository(Id contactId) {
        this.contactId = contactId;
    }
    
    public Result findAllSoftCredits() {
        Result retVal = new Result();
        retVal.contactId = this.contactId;
        
        List<SObject> pscs = findPSCs();
        List<OpportunityContactRole> ocrs = findOCRs();
        Set<Id> handledOCRIds = new Set<id>();
        
        for(SObject psc : pscs) {
            retVal.creditObjects.add(new CreditObject(psc));
            handledOCRIds.add((Id)psc.get('npsp__Contact_Role_ID__c'));
        }
        for(OpportunityContactRole ocr : ocrs) {
            retVal.opportunities.put(ocr.OpportunityId, ocr.Opportunity);
            if (!handledOCRIds.contains(ocr.Id)) {
                retVal.creditObjects.add(new CreditObject((SObject)ocr));
            }
        }
        retVal.numOCRs = ocrs.size();
        retVal.numPSCs = pscs.size();
        
        return retVal;
    }
    
    private List<SObject> findPSCs() {
        List<SObject> retVal = new List<SObject>();
        retval = Database.query(getPSCQuery());
        return retVal;
    }
    
    private List<OpportunityContactRole> findOCRs() {
        List<OpportunityContactRole> retVal = new List<OpportunityContactRole>();
        retVal = Database.query(getOCRQuery());
        return retVal;
    }
        
    private String getPSCQuery() {
        fflib_QueryFactory q = new fflib_QueryFactory(npsp__Partial_Soft_Credit__c.SObjectType);
        q.selectFields(new List<String>{
            'Name',
            'Id',
            'npsp__Role_Name__c',
            'npsp__Opportunity__c',
            'npsp__Opportunity__r.CloseDate',
            'npsp__Contact_Role_ID__c',
            'npsp__Amount__c'
        });
        Id contactId = this.contactId;
        q.setCondition('npsp__Contact__c = :contactId');
        return q.toSoql();
    }
    
    private String getOCRQuery() {
    	fflib_QueryFactory q = new fflib_QueryFactory(OpportunityContactRole.SObjectType);
        q.selectFields(new List<String> {
            'OpportunityId',
            'Role',
            'Opportunity.Name',
            'Opportunity.StageName',
            'Opportunity.CloseDate',
            'Opportunity.Amount'
        });
        Id contactId = this.contactId;
        q.setCondition('ContactId = :contactId');
        return q.toSoql();
    }
    
    public class CreditObject implements Comparable {
        private SObject sobj;
        public SObjectType sobjecttype {get { return sobj.getSObjectType();}}
        public Date creditDate {get {
            if (sobj.getSObjectType() == OpportunityContactRole.SObjectType) {
                return (Date)sobj.getSObject('Opportunity').get('CloseDate');
            } else {
                return (Date)sobj.getSObject('npsp__Opportunity__r').get('CloseDate');
            }
        }}
        private CreditObject(SObject sobj){
            this.sobj = sobj;
        }
        public Integer compareTo(Object compareTo) {
            CreditObject compareObj = (CreditObject)compareTo;
            
            if (creditDate > compareObj.creditDate) {
                return 1;
            } else if (creditDate < compareObj.creditDate) {
                return -1;
            } else {
                return 0;
            }
        }
        public Object get(String name) {
            return this.sobj.get(name);
        }
        public SObject getSObject(String name) {
            return this.sobj.getSObject(name);
        }
    }
        
    public class Result {
        public Id contactId {get;set;}
        
        private Boolean sorted = false;
        
        public Integer numOpportunities {get {return this.opportunities.size();}}
        public Integer numOCRs {get;set;}
        public Integer numPSCs {get;set;}
        public List<CreditObject> creditObjects {get{
            if (!sorted){ this.creditObjects.sort(); }
            return this.creditObjects;
        } set;}
        public Map<Id,Opportunity> opportunities {get;set;}
        public Result(){
            this.opportunities = new Map<Id,Opportunity>();
            this.creditObjects = new List<CreditObject>();
        }

    }
}