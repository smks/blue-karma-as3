package bluekarma.interactive.base
{
    import bluekarma.interactive.backalley.repos.BackAlleyInteractionRepo;
    import bluekarma.interactive.compound.repos.CompoundInteractionRepo;
    import bluekarma.interactive.slumsstreet.repos.SlumsStreetInteractionRepo;

    import interactive.albertscar.repos.AlbertsCarInteractionRepo;
    import interactive.apartment.repos.ApartmentInteractionRepo;

    /**
     * @author Shaun Stone
     */
    public class InteractionRepoFactory
    {
        public static const APARTMENT_1:String = "apartment_1";
        public static const ALBERTS_CAR:String = "alberts_car";
        public static const SLUMS_STREET:String = "slums_1";
        public static const BACK_ALLEY:String = "back_alley";
        public static const COMPOUND:String = "compound";
        private static var apartmentRepo:ApartmentInteractionRepo;
        private static var albertsCarRepo:AlbertsCarInteractionRepo;
        private static var slumsStreetRepo:SlumsStreetInteractionRepo;
        private static var backAlleyRepo:BackAlleyInteractionRepo;
        private static var compoundRepo:CompoundInteractionRepo;

        public static function getInteractionRepo(repo:String):*
        {
            switch (repo) {
                case APARTMENT_1:
                    if (InteractionRepoFactory.apartmentRepo == null) {
                        InteractionRepoFactory.apartmentRepo = new ApartmentInteractionRepo();
                    }
                    return InteractionRepoFactory.apartmentRepo;
                    break;
                case ALBERTS_CAR:
                    if (InteractionRepoFactory.albertsCarRepo == null) {
                        InteractionRepoFactory.albertsCarRepo = new AlbertsCarInteractionRepo();
                    }
                    return InteractionRepoFactory.albertsCarRepo;
                    break;
                case SLUMS_STREET:
                    if (InteractionRepoFactory.slumsStreetRepo == null) {
                        InteractionRepoFactory.slumsStreetRepo = new SlumsStreetInteractionRepo();
                    }
                    return InteractionRepoFactory.slumsStreetRepo;
                    break;
                case BACK_ALLEY:
                    if (InteractionRepoFactory.backAlleyRepo == null) {
                        InteractionRepoFactory.backAlleyRepo = new BackAlleyInteractionRepo();
                    }
                    return InteractionRepoFactory.backAlleyRepo;
                    break;
                case COMPOUND:
                    if (InteractionRepoFactory.compoundRepo == null) {
                        InteractionRepoFactory.compoundRepo = new CompoundInteractionRepo();
                    }
                    return InteractionRepoFactory.compoundRepo;
                    break;
            }
            throw new Error("Interaction repo not found");
            // return anyway
            return false;
        }
    }
}