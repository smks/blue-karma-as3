package interactive.apartment.props.living_room
{
    import assets.RileyApartmentAssets;

    import com.greensock.TweenLite;

    import interactive.base.Prop;

    import settings.backgrounds.apartment.cityview.CityView;

    import starling.display.Image;

    /**
     * ...
     * @author @shaunstone
     */
    public class SmartWindow extends Prop
    {
        private var windowScreen:Image;
        private var windowFrame:Image;
        private var viewCount:uint = 0;

        public function SmartWindow(id:String, examinable:Boolean = false)
        {
            super(id, examinable);
        }

        override protected function getPropAsset(id:String):void
        {
            var screen:String = RileyApartmentAssets.LIVING_ROOM_SMART_WINDOW_SCREEN;
            var frame:String = RileyApartmentAssets.LIVING_ROOM_SMART_WINDOW_FRAME;
            //create rug
            windowScreen = new Image(RileyApartmentAssets.getAtlas().getTexture(screen));
			windowScreen.scaleX = 4;
			windowScreen.scaleY = 4;
			windowScreen.width = 562;
			windowScreen.height = 397;
            windowFrame = new Image(RileyApartmentAssets.getAtlas().getTexture(frame));
			windowFrame.width = 562;
			windowFrame.height = 397;
			windowFrame.scaleX = 4;
			windowFrame.scaleY = 4;
            //add to stage
            addChild(windowScreen);
            addChild(windowFrame);
        }

        override public function triggerExamine(params:Object = null):void
        {
            super.triggerExamine();
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject(params);
        }

        public function showView():void
        {
            TweenLite.to(windowScreen, 2, {alpha: 0});
        }

        public function showInterface():void
        {
            TweenLite.to(windowScreen, 2, {alpha: 1});
        }

        public function displayMessage():void
        {
            //@TODO
        }

        public function showFrontDoor():void
        {
            //@TODO
        }

        public function getViewCount():uint
        {
            return viewCount;
        }

        public function addViewCount():void
        {
            viewCount++;
        }
    }
}