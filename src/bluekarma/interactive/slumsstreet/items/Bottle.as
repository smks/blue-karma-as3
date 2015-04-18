package interactive.slumsstreet.items
{
    import assets.ItemAssets;

    import bluekarma.interactive.base.InteractionRepoFactory;
    import bluekarma.interactive.base.Item;

    import starling.display.Image;

    /**
     * ...
     * @author @shaun
     */
    public class Bottle extends Item
    {
        private const LEVEL:String = "bottle";
        private const INVENTORY:String = "bottle_inventory";
        private var bottleLevel:Image;
        private var bottleInventory:Image;

        public function Bottle(id:String, actionable:Boolean = false)
        {
            super(id, actionable);
            
        }

        override protected function drawItem():void
        {
            bottleLevel = new Image(ItemAssets.getAtlas().getTexture(ItemAssets.BOTTLE));
            bottleLevel.visible = true;
            addChild(bottleLevel);
            bottleInventory = new Image(ItemAssets.getAtlas().getTexture(ItemAssets.BOTTLE_INV));
            bottleInventory.visible = false;
            addChild(bottleInventory);
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
                // change to inventory image
                bottleInventory.visible = true;
                bottleLevel.visible = false;
            } else {
                //switch back to level image
                bottleInventory.visible = false;
                bottleLevel.visible = true;
            }
        }

        override protected function getRepo():void
        {
            _repoId = InteractionRepoFactory.SLUMS_STREET;
            _repo = InteractionRepoFactory.getInteractionRepo(_repoId);
        }
    }
}