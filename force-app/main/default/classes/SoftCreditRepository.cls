public class SoftCreditRepository {
    // find the appropriate soft credits and merge the streams
    
    public Id contactId {get;set;}
    
    public SoftCreditRepository(Id contactId) {
        this.contactId = contactId;
    }
    
    public Result findAllSoftCredits() {
        Result retVal = new Result();
        throw new NotImplementedException();
        //return retVal;
    }
    
    private List<SObject> findPSCs() {
        List<SObject> retVal = new List<SObject>();
        retVal = Database.query(getPSCQuery());
        return retVal;
    }
    
    private String getPSCQuery() {
        return '';
    }
    
    public class Result {
        public Integer numOpportunities {get;set;}
        public Integer numOCRs {get;set;}
        public Integer numPSCs {get;set;}
        public List<sObject> creditObjects {get;set;}
        public Map<Id,Opportunity> opportunities {get;set;}
    }
}