package interactive.backalley.items
{
    import assets.BackAlleyAssets;
    import assets.ItemAssets;

    import bluekarma.interactive.base.InteractionRepoFactory;
    import bluekarma.interactive.base.Item;

    import starling.display.Image;

    /**
     * Interactive Item: FanKeys
     * @author Shaun Stone
     * Created at: 01-01-2015 15:44:38
     */
    public class FanKeys extends Item
    {
        /**
         * The image retrieved from Assets
         *
         */
        private var image:Image;
        private var imageInventory:Image;
		private var takenFromToolbox:Boolean = false;

        /**
         * The Main Contructor for FanKeys
         * @param id
         * @param pickable
         */
        public function FanKeys(id:String, pickable:Boolean = false)
        {
            super(id, pickable);
            setExaminable(true);
            setInInventory(false);
            setInFocus(false);
        }

        /**
         * Retrieve Image from assets then draw the item
         *
         */
        override protected function drawItem():void
        {
            image = new Image(BackAlleyAssets.getAtlas().getTexture(BackAlleyAssets.FAN_KEYS));
            addChild(image);
            imageInventory = new Image(ItemAssets.getAtlas().getTexture(ItemAssets.FAN_KEYS));
            addChild(imageInventory);
            // show keys on floor first
            changeItemImage(false);
        }

        /**
         * The image we show on the level may not be suitable
         * for the inventory (too long, wide) so we swap the image
         * with something more fitting
         * @param    inInventory
         */
        override public function changeItemImage(inInventory:Boolean = true):void
        {
            if (inInventory) {
                image.visible = false;
                imageInventory.visible = true;
            } else {
                image.visible = true;
                imageInventory.visible = false;
            }
        }

        /**
         * Choose the repo to retrieve the prop from
         */
        override protected function getRepo():void
        {
            _repoId = InteractionRepoFactory.BACK_ALLEY;
            _repo = InteractionRepoFactory.getInteractionRepo(_repoId);
        }

        /**
         * Override Trigger Interaction Object and create new behaviour for Item
         * @examples
         *  params.currentState - trigger an object dependent on the state of level
         *  params.playerPosition - x position to determine if player is near the object
         *  params.* pass in anything necessary
         */
        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject(params);
        }

        /**
         * When TriggerExamine is called, we may want to do
         * something other than what's expected for the item
         * @param params - pass in parameters we may want to use
         */
        override public function triggerExamine(params:Object = null):void
        {
            super.triggerExamine(params);
        }

        /**
         * Item can be different on each level - using switch statement
         * @param level
         * @example
         *
         *   switch (level)
         *    {
		**		case APARTMENT:
		*			_repoId = InteractionRepoFactory.APARTMENT_1;
		*			_repo = InteractionRepoFactory.getInteractionRepo(_repoId);
		*		break;
		*
		*		case CAR:
		*			_repoId = InteractionRepoFactory.ALBERTS_CAR;
		*			_repo = InteractionRepoFactory.getInteractionRepo(_repoId);
		*		break;
		*	}
         */
        public function setLevelItem(level:String):void
        {
        }
		
		public static function getId():String
		{
			return 'fan-keys';
		}
		
		public function takeFromBox():void
		{
			takenFromToolbox = true;
		}
		
		public function takenFromToolBox():Boolean 
		{
			return takenFromToolbox;
		}
    }
}