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
    public class DigiCuffs extends Item
    {
        public static const CAR:String = "car";
        public static const STREETS:String = "streets";
        private var cuffs:Image;
        private var engaged:Boolean = false;
        private var currentLevel:String = "journey";

        public function DigiCuffs(id:String, pickable:Boolean = false)
        {
            super(id, pickable);
            setTrashable(false);
            setCombinable(false);
        }

        public static function getId():String
        {
            return 'digi_cuffs';
        }

        override protected function drawItem():void
        {
            cuffs = new Image(ItemAssets.getAtlas().getTexture(ItemAssets.DIGICUFFS));
            addChild(cuffs);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject();
        }

        override public function setGlow(glow:Boolean = false):void
        {
            if (cuffs === null) {
                return;
            }
            if (glow === true) {
                cuffs.filter = BlurFilter.createGlow(Global.BLUE_KARMA_GLOW_YELLOW, 1, 4, 2);
            } else {
                cuffs.filter = null;
            }
        }

        /**
         * Digicuffs can be different
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