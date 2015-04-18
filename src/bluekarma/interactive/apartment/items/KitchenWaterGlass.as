package interactive.apartment.items
{
    import bluekarma.assets.sound.SoundAssets;
    import bluekarma.interactive.base.Item;

    import assets.ItemAssets;

    import starling.display.Image;

    /**
     * ...
     * @author Shaun Stone
     */
    public class KitchenWaterGlass extends Item
    {
        private const GLASS_ID:String = "kitchen_glass";
        private var image:Image;
        private var imageInventory:Image;
        private var containsWater:Boolean = false;

        public function KitchenWaterGlass(id:String, pickable:Boolean = false)
        {
            super(id, pickable);
            setTrashable(false);
            setCombinable(true);
        }

        override protected function drawItem():void
        {
            image = new Image(ItemAssets.getAtlas().getTexture(ItemAssets.KITCHEN_GLASS));
            image.width = 27;
            image.height = 34;
            addChild(image);
            imageInventory = new Image(ItemAssets.getAtlas().getTexture(ItemAssets.KITCHEN_GLASS));
            imageInventory.x = 10;
            addChild(imageInventory);
            imageInventory.visible = false;
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

        public function addWater():void
        {
            this.containsWater = true;
            SoundAssets.fillUpGlassWithWater.play();
        }

        public function hasWater():Boolean
        {
            return containsWater;
        }
    }
}