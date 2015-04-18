package bluekarma.interactive.general.items
{
    import assets.ItemAssets;

    import bluekarma.interactive.base.InteractionRepoFactory;
    import bluekarma.interactive.base.Item;

    import starling.display.Image;

    /**
     * A chip is implanted in the arm of any player
     * @author Shaun Stone
     */
    public class Chip extends Item
    {
        public static const APARTMENT:String = "apartment";
        public static const CAR:String = "car";
        public static const STREETS:String = "streets";
        private var chip:Image;
        private var engaged:Boolean = false;

        public function Chip(id:String, pickable:Boolean = false)
        {
            super(id, pickable);
            setTrashable(false);
            setCombinable(false);
        }

        override protected function drawItem():void
        {
            chip = new Image(ItemAssets.getAtlas().getTexture(ItemAssets.CHIP));
            addChild(chip);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject();
        }

        /**
         * Chip can be different
         * @param    level
         */
        public function setLevelItem(level:String):void
        {
            switch (level) {
                case APARTMENT:
                    _repoId = InteractionRepoFactory.APARTMENT_1;
                    break;
                case CAR:
                    _repoId = InteractionRepoFactory.ALBERTS_CAR;
                    break;
                case STREETS:
                    _repoId = InteractionRepoFactory.SLUMS_STREET;
                    break;
                default:
                    throw new Error("Couldn't set level item");
            }
            _repo = InteractionRepoFactory.getInteractionRepo(_repoId);
        }
    }
}