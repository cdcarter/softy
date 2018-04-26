public class SoftCreditDataSource {
	@auraEnabled
    public static SoftCredit getDataForContact(Id contactId) {
		SoftCreditRepository repo = new SoftCreditRepository(contactId);
		SoftCredit sc = SoftCreditMapper.go(repo.findAllSoftCredits());
        return sc;
    }
}