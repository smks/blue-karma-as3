package settings.backgrounds.apartment.cityview
{
    import adobe.utils.CustomActions;

    import assets.settings.backgrounds.cityview.CityViewAssets;

    import com.greensock.TweenLite;

    import global.Global;

    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;

    /**
     * ...
     * @author @shaun
     */
    public class FlyingVehicle extends Sprite
    {
        private const CLOSE:Number = 0.6;
        private const MID:Number = 0.4;
        private const FAR:Number = 0.2;
        private const PREFIX:String = 'ship-';
        private var id:uint;

        /**
         * 1 - 12
         * @param    id
         */
        public function FlyingVehicle(id:uint = 1)
        {
            if (id === 0) {
                id = 1;
            }
            if (id > 12 || id < 1) {
                throw new Error("ID doesn't exist");
            }
            this.id = id;
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        public function setSizeAndDirection(direction:String, distance:uint = 1):void
        {
            if (direction === Global.LEFT) {
                switch (distance) {
                    case 1 :
                        this.scaleX = CLOSE;
                        this.scaleY = CLOSE;
                        break;
                    case 2 :
                        this.scaleX = MID;
                        this.scaleY = MID;
                        break;
                    case 3 :
                        this.scaleX = FAR;
                        this.scaleY = FAR;
                }
            } else {
                this.x += this.width;
                switch (distance) {
                    case 1 :
                        this.scaleX = -CLOSE;
                        this.scaleY = -CLOSE;
                        break;
                    case 2 :
                        this.scaleX = -MID;
                        this.scaleY = -MID;
                        break;
                    case 3 :
                        this.scaleX = -FAR;
                        this.scaleY = -FAR;
                }
            }
        }

        public function getId():uint
        {
            return this.id;
        }

        private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            draw();
        }

        private function draw():void
        {
            var ship:Image = new Image(CityViewAssets.getAtlas().getTexture(PREFIX + this.id));
            addChild(ship);
        }
    }
}