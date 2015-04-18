package settings.backgrounds
{
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.display.Image;

    import assets.Level1Assets;

    /**
     * ...
     * @author Shaun Stone
     */
    public class BackgroundSlumsAlley extends Sprite
    {
        protected var _backgroundName:String;
        protected var _pos:uint;
        private var bg:Image;

        public function BackgroundSlumsAlley()
        {
            this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        public function getPosition():uint
        {
            return _pos;
        }

        private function onAdded(e:Event):void
        {
            this.removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            drawBackground();
        }

        private function drawBackground():void
        {
            //add bg
            bg = new Image(Level1Assets.getTexture("SlumsAlleywayBackgroundImage"));
            bg.y = -stage.stageHeight;
            this.addChild(bg);
        }
    }
}