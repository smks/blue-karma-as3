package interactive.apartment.items
{
    import assets.ItemAssets;

    import bluekarma.interactive.base.Item;

    import starling.display.Image;

    /**
     * ...
     * @author Shaun Stone
     */
    public class DogFood extends Item
    {
        private var dogFood:Image;

        public function DogFood(id:String, pickable:Boolean = false)
        {
            super(id, pickable);
            setTrashable(false);
            setCombinable(true);
			
        }

        override protected function drawItem():void
        {
            dogFood = new Image(ItemAssets.getAtlas().getTexture(ItemAssets.DOG_FOOD));
            addChild(dogFood);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject();
        }
    }
}