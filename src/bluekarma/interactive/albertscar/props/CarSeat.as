package interactive.albertscar.props
{
    import bluekarma.assets.settings.backgrounds.albertscar.AlbertJourneyAssets;
    import bluekarma.interactive.base.InteractionRepoFactory;

    import interactive.base.Prop;

    import starling.display.Image;

    /**
     *
     * @author ...
     */
    public class CarSeat extends Prop
    {
        public static const FRONT_DRIVER:String = "front_driver_seat";
        public static const FRONT_PASSENGER:String = "front_passenger_seat";
        public static const BACK_DRIVER:String = "back_driver_seat";
        public static const BACK_PASSENGER:String = "back_passenger_seat";
        private var seat:Image;

        public function CarSeat(id:String, examinable:Boolean = false)
        {
            super(id, examinable);
        }

        override protected function getPropAsset(id:String):void
        {
            if (seat == null) {
                switch (id) {
                    case FRONT_DRIVER :
                        seat = new Image(AlbertJourneyAssets.getAtlas().getTexture("car-seat"));
                        break;
                    case BACK_DRIVER :
                        seat = new Image(AlbertJourneyAssets.getAtlas().getTexture("car-seat"));
                        seat.width = 267;
                        seat.height = 383;
                        break;
                    case FRONT_PASSENGER :
                        seat = new Image(AlbertJourneyAssets.getAtlas().getTexture("car-seat"));
                        break;
                    case BACK_PASSENGER :
                        seat = new Image(AlbertJourneyAssets.getAtlas().getTexture("car-seat"));
                        seat.width = 267;
                        seat.height = 383;
                        break;
                }
                addChild(seat);
            }
        }

        override protected function getRepo():void
        {
            _repoId = InteractionRepoFactory.ALBERTS_CAR;
            _repo = InteractionRepoFactory.getInteractionRepo(_repoId);
        }
    }
}