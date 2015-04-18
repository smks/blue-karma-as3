package interactive.backalley.items

{
    import assets.BackAlleyAssets;
    import assets.ItemAssets;
	import global.Global;

    import bluekarma.interactive.base.InteractionRepoFactory;
    import bluekarma.interactive.base.Item;

    import starling.display.Image;

    /**
     * Interactive Item: Cable
     * @author Shaun Stone
     * Created at: 26-12-2014 19:12:36
     */
    public class Cable extends Item
    {
        /**
         * The image retrieved from Assets
         *
         */
        private var cableHanging:Image;
        private var cablePickedUp:Image;
        private var pickedUp:Boolean = false;
        /*
         * Main Constructor, override any default properties here
         */
        public function Cable(id:String, pickable:Boolean = false)
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
            cableHanging = new Image(BackAlleyAssets.getAtlas().getTexture(BackAlleyAssets.CABLE_HANGING));
            addChild(cableHanging);
            cablePickedUp = new Image(ItemAssets.getAtlas().getTexture(ItemAssets.CABLE));
            cablePickedUp.visible = false;
            addChild(cablePickedUp);
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
                // hide
                cableHanging.visible = false;
                // change to inventory image
                cablePickedUp.visible = true;
                // we don't show this anymore as it has been picked up
                cableHanging = null;
            }
        }

        override protected function getRepo():void
        {
            _repoId = InteractionRepoFactory.BACK_ALLEY;
            _repo = InteractionRepoFactory.getInteractionRepo(_repoId);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            var sideToMove:String;
            if (!_inInventory) {
                if (params.level === undefined) {
                    throw new Error("level needs to be defined");
                }
				
				if (params.level.getBackground().getRileyOnLadderDirection() === Global.LEFT) {
					// need to set in inventory before adding
					setInInventory(true);
					params.level.getInventory().addItem(this);
				} else {
					params.level.triggerItemThoughtMessage('get_closer');
				}
                
            } else {
                super.triggerInteractionObject(params);
            }
        }

        /*
         * Override Trigger Interaction Object and create new behaviour for Item
         * @examples
         *  params.currentState - trigger an object dependent on the state of level
         *  params.playerPosition - x position to determine if player is near the object
         *  params.* pass in anything necessary
         */
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
    }
}