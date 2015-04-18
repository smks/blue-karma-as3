package interactive.apartment.props.living_room
{
    import interactive.base.Prop;

    import starling.display.Image;

    import assets.RileyApartmentAssets;

    /**
     * ...
     * @author Shaun Stone
     */
    public class LivingRoomCoffeeTable extends Prop
    {
        private var table:Image;

        public function LivingRoomCoffeeTable(id:String, _examinable:Boolean)
        {
            super(id, _examinable);
        }

        override protected function getPropAsset(id:String):void
        {
            var tableName:String = RileyApartmentAssets.LIVING_ROOM_COFFEE_TABLE;
            //create rug
            table = new Image(RileyApartmentAssets.getAtlas().getTexture(tableName));
            //add to stage
            addChild(table);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject(params);
        }
    }
}