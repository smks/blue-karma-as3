package interactive.apartment.items
{
    import assets.ItemAssets;

    import bluekarma.interactive.base.Item;

    import starling.display.Image;

    /**
     * ...
     * @author Shaun Stone
     */
    public class KitchenPlate extends Item
    {
        private const PLATE_ID:String = "kitchen_plate";
        protected var plate:Image;

        public function KitchenPlate(id:String, pickable:Boolean = false)
        {
            super(id, pickable);
        }

        override protected function drawItem():void
        {
            plate = new Image(ItemAssets.getAtlas().getTexture(ItemAssets.KITCHEN_PLATE));
            plate.width = 76;
            plate.height = 15;
            addChild(plate);
        }
    }
}