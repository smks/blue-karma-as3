package interactive.apartment.items
{
    import assets.ItemAssets;

    import bluekarma.interactive.base.Item;

    import starling.display.Image;

    /**
     * ...
     * @author Shaun Stone
     */
    public class KitchenFoodBowl extends Item
    {
        private const BOWL_ID:String = "kitchen_bowl";
        protected var bowl:Image;

        public function KitchenFoodBowl(id:String, pickable:Boolean = false)
        {
            super(id, pickable);
            setTrashable(false);
            setCombinable(true);
        }

        override protected function drawItem():void
        {
            bowl = new Image(ItemAssets.getAtlas().getTexture(ItemAssets.KITCHEN_BOWL));
            bowl.width = 40;
            bowl.height = 20;
            addChild(bowl);
        }
    }
}