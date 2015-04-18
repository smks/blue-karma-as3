package bluekarma.interactive.general.items
{
    import assets.ItemAssets;

    import global.Global;

    import starling.filters.BlurFilter;

    import bluekarma.interactive.base.InteractionRepoFactory;
    import bluekarma.interactive.base.Item;

    import starling.display.Image;

    /**
     * ...
     * @author Shaun Stone
     */
    public class LockPick extends Item
    {
        public static const CAR:String = "car";
        public static const STREETS:String = "streets";
        protected var lockPick:Image;

        public function LockPick(id:String, pickable:Boolean = false)
        {
            super(id, pickable);
            setTrashable(false);
            setCombinable(false);
        }

        public static function getId():String
        {
            return 'lock_pick';
        }

        override protected function drawItem():void
        {
            lockPick = new Image(ItemAssets.getAtlas().getTexture(ItemAssets.LOCKPICK));
            lockPick.filter
            addChild(lockPick);
        }

        override public function setGlow(glow:Boolean = false):void
        {
            if (lockPick === null) {
                return;
            }
            if (glow === true) {
                lockPick.filter = BlurFilter.createGlow(Global.BLUE_KARMA_GLOW_YELLOW, 1, 4, 2);
            } else {
                lockPick.filter = null;
            }
        }

        /**
         * Lockpick can be different
         * @param    level
         */
        public function setLevelItem(level:String):void
        {
            switch (level) {
                case CAR:
                    _repoId = InteractionRepoFactory.ALBERTS_CAR;
                    _repo = InteractionRepoFactory.getInteractionRepo(_repoId);
                    break;
                case STREETS:
                    _repoId = InteractionRepoFactory.SLUMS_STREET;
                    _repo = InteractionRepoFactory.getInteractionRepo(_repoId);
                    break;
            }
        }
    }
}