public class SoftCreditMapper {
    // get the merged stream and turn it into aura enabled softies
    public SoftCreditMapper() {
        throw new SingletonException('Cannot instantiate SoftCreditMapper');
    }
    
    public static SoftCredit mapSoftCredits(SoftCreditRepository.Result result) {
        SoftCredit retVal = new SoftCredit();
		throw new NotImplementedException();
        //return retVal;
    }
}