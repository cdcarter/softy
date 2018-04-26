public class SoftCredit {
    // MODEL JUST FOR SERIALIZATION
    // USES JS STYLE NAMES
    @auraEnabled
    public List<Item> soft_credits = new List<Item>();
    @auraEnabled
    public Integer total_records {get;set;}
    
    public with sharing class Item {
        @auraEnabled
        public Id psc_id {get;set;}
        @auraEnabled
        public Id ocr_id {get;set;}
        @auraEnabled
        public Id oppty_id {get;set;}
        @auraEnabled
        public Id contact_id {get;set;}
        @auraEnabled
        public String oppty_name {get;set;}
        @auraEnabled
        public String role {get;set;}
        @auraEnabled
        public Decimal amount {get;set;}
        @auraEnabled
        public Date opportunity_date {get;set;}
        @auraEnabled
        public Boolean partial {get;set;}
    }
}