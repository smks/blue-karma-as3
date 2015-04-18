package interactive.slumsalley.items
{
    import assets.ItemAssets;

    import bluekarma.interactive.base.Item;

    import starling.display.Image;

    /**
     * Interactive Item: Pipe
     * @author Shaun Stone
     * Created at: 25-10-2014 11:36:29
     */
    public class Pipe extends Item
    {
        /**
         * The image retrieved from Assets
         *
         */
        private var image:Image;
        /*
         * Main Constructor, override any default properties here
         */
        public function Pipe(id:String, pickable:Boolean = false)
        {
            super(id, pickable);
            setExaminable(true);
            setInInventory(true);
            setInFocus(false);
        }

        /**
         * Retrieve Image from assets then draw the item
         *
         */
        override protected function drawItem():void
        {
            image = new Image(ItemAssets.getAtlas().getTexture(ItemAssets.PIPE));
            image.width = 100;
            image.height = 100;
            image.scaleX = 1;
            image.scaleY = 1;
            addChild(image);
        }

        /**
         * The image we show on the level may not be suitable
         * for the inventory (too long, wide) so we swap the image
         * with something more fitting
         * @param    inInventory
         */
        override public function changeItemImage(inInventory:Boolean = true):void
        {
            super.changeItemImage(inInventory);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject();
        }

        /*
         * Override Trigger Interaction Object and create new behaviour for Item
         * @examples
         *  params.currentState - trigger an object dependent on the state of level
         *  params.playerPosition - x position to determine if player is near the object
         *  params.* pass in anything necessary
         */
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

        /**
         * When TriggerExamine is called, we may want to do
         * something other than what's expected for the item
         * @param params - pass in parameters we may want to use
         */
        public function triggerExamine(params:Object = null):void
        {
            super.triggerExamine(params);
        }
    }
}