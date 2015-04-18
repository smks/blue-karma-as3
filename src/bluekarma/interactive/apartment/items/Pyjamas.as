package interactive.apartment.items
{
    import assets.ItemAssets;

    import bluekarma.interactive.base.Item;

    import starling.display.Image;

    /**
     * ...
     * @author Shaun Stone
     */
    public class Pyjamas extends Item
    {
        protected var clothing:Image;

        public function Pyjamas(id:String, pickable:Boolean = false)
        {
            super(id, pickable);
            setTrashable(false);
            setCombinable(false);
        }

        override protected function drawItem():void
        {
            clothing = new Image(ItemAssets.getAtlas().getTexture(ItemAssets.PYJAMAS));
            addChild(clothing);
        }
    }
}