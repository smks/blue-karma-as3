package interactive.apartment.items
{
    import assets.ItemAssets;

    import bluekarma.interactive.base.Item;

    import starling.display.Image;

    /**
     * ...
     * @author Shaun Stone
     */
    public class DogBowl extends Item
    {
        private var dogBowl:Image;
        private var dogBowlFull:Image;
        private var _full:Boolean;

        public function DogBowl(id:String, pickable:Boolean = false)
        {
            super(id, pickable);
            setTrashable(false);
            setCombinable(true);
			
        }

        override protected function drawItem():void
        {
            dogBowl = new Image(ItemAssets.getAtlas().getTexture(ItemAssets.DOG_BOWL));
            addChild(dogBowl);
            dogBowlFull = new Image(ItemAssets.getAtlas().getTexture(ItemAssets.DOG_BOWL_FULL));
            dogBowlFull.visible = false;
            addChild(dogBowlFull);
        }

        public function fillWithFood():void
        {
            setFull(true);
            dogBowl.visible = false;
            dogBowlFull.visible = true;
        }

        public function emptyDogBowl():void
        {
            setFull(false);
            dogBowl.visible = true;
            dogBowlFull.visible = false;
        }

        public function isFull():Boolean
        {
            return _full;
        }

        public function setFull(value:Boolean):void
        {
            _full = value;
        }
    }
}