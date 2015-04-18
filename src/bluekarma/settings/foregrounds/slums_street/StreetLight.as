package settings.foregrounds.slums_street
{
    import adobe.utils.CustomActions;

    import assets.Level1Assets;

    import starling.display.BlendMode;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;

    /**
     * ...
     * @author @shaun
     */
    public class StreetLight extends Sprite
    {
        private var on:Boolean;
        private var lightOff:Image;
        private var lightOn:Image;
        private var light:Image;

        public function StreetLight(on:Boolean = true)
        {
            this.on = on;
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        public function turnOn():void
        {
            lightOff.visible = false;
            lightOn.visible = true;
            light.visible = true;
        }

        public function turnOff():void
        {
            lightOff.visible = true;
            lightOn.visible = false;
            light.visible = false;
        }

        private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            draw();
        }

        private function draw():void
        {
            lightOff = new Image(Level1Assets.getTexture(Level1Assets.SLUMSFOREGROUNDSTREETLIGHTOFF));
            addChild(lightOff);
            light = new Image(Level1Assets.getTexture("SlumsForegroundStreetLightLight"));
            light.scaleX = 2;
            light.scaleY = 2;
            light.y = -142;
            light.blendMode = BlendMode.SCREEN;
            light.alpha = 0.6;
            addChild(light);
            trace("light x is: ", light.x);
            lightOn = new Image(Level1Assets.getTexture(Level1Assets.SLUMSFOREGROUNDSTREETLIGHTON));
            addChild(lightOn);
            (on) ? turnOn() : turnOff();
        }
    }
}