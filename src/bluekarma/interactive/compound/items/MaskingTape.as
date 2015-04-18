package bluekarma.interactive.compound.items
{
    import assets.CompoundAssets;
    import assets.ItemAssets;

    import bluekarma.interactive.base.InteractionRepoFactory;
    import bluekarma.interactive.base.Item;

    import starling.display.Image;

    /**
     * Interactive Item: MaskingTape
     * @author Shaun Stone (SMKS)
     * @website http://www.smks.co.uk
     * Created at: 17-02-2015 17:05:09
     */
    public class MaskingTape extends Item
    {
        /**
         * The images retrieved from Assets
         *
         */
        private var image:Image;
        private var imageInventory:Image;

        /**
         * The Main Contructor for MaskingTape
         *
         * @param id
         * @param pickable
         */
        public function MaskingTape(id:String, pickable:Boolean = false)
        {
            super(id, pickable);
            setExaminable(true);
            setInInventory(false);
            setInFocus(false);
            
        }

        public static function getId():String
        {
            return 'masking-tape';
        }

        /**
         * Retrieve Image from assets then draw the item
         *
         */
        override protected function drawItem():void
        {
            // this image appears in the compound room
            image = new Image(CompoundAssets.getAtlas().getTexture(CompoundAssets.MASKING_TAPE));
            addChild(image);
            // this image appears in inventory
            imageInventory = new Image(ItemAssets.getAtlas().getTexture(ItemAssets.MASKING_TAPE));
            imageInventory.visible = false;
            addChild(imageInventory);
        }

        /**
         * Use compound repo
         */
        override protected function getRepo():void
        {
            _repoId = InteractionRepoFactory.COMPOUND;
            _repo = InteractionRepoFactory.getInteractionRepo(_repoId);
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
    }
}