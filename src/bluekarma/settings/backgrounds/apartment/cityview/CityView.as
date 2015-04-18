package settings.backgrounds.apartment.cityview
{
    import assets.settings.backgrounds.cityview.CityViewAssets;

    import com.greensock.easing.Circ;
    import com.greensock.easing.Expo;
    import com.greensock.easing.Quint;
    import com.greensock.TweenLite;

    import flash.events.TimerEvent;
    import flash.geom.Rectangle;
    import flash.utils.Timer;

    import global.Global;

    import particles.RainParticle;

    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;

    /**
     * This class shows the city view in apartment background,
     * behind the Smart Home Windowe
     *
     *
     * @author @shaun
     */
    public class CityView extends Sprite
    {
        private const BG:String = 'city_bg';
        private const MAX_SHIPS:uint = 10;
        private const GROWTH_VALUE:uint = 10;
        // view port
        private var windowWidth:uint = 562;
        private var windowHeight:uint = 392;
        private var cityBg:Image;
        private var showShips:Boolean = false;
        private var timer:Timer;
        private var _rain:RainParticle;

        public function CityView(animation:Boolean = false)
        {
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
            if (animation === true) {
                this.enableShips().triggerFlyingVehicle();
            }
        }

        public function addShip(direction:String = Global.LEFT, distance:uint = 1):void
        {
            var xTarget:Number;
            var duration:Number;
            var ship:FlyingVehicle = FlyingVehiclePool.getShip();
            addChild(ship);
            if (direction == Global.LEFT) {

                // set starting position
                ship.x = this.width + ship.width;
                // x position to end up at
                xTarget = -(this.width + ship.width);
            } else {

                // set starting position
                ship.x = -(ship.width * 2);
                // x position to end up at right
                xTarget = (this.width + (ship.width * 3));
            }
            duration = 4;
            ship.setSizeAndDirection(direction, distance);
            switch (distance) {
                case 1:
                    ship.y = 150;
                    duration *= 1.2;
                    break;
                case 2:
                    ship.y = 125;
                    duration *= 1.4;
                    break;
                case 3:
                    ship.y = 100;
                    duration *= 1.6;
            }
            // tween ship
            TweenLite.to(ship, duration, {
                x: xTarget,
                onComplete: removeShip,
                onCompleteParams: [ship],
                ease: Quint.easeInOut
            });
        }

        public function triggerFlyingVehiclePastBuilding():void
        {
            // @TODO
        }

        /**
         * This will show vehicles flying (close, mid shot and far away)
         */
        public function triggerFlyingVehicle():void
        {
            if (showShips) {
                timer = new Timer(1000, 2);
                timer.addEventListener(TimerEvent.TIMER_COMPLETE, addShipHandler);
                //timer.start();
            } else {
                trace("show ships not enabled");
            }
        }

        public function enableShips():CityView
        {
            showShips = true;
            return this;
        }

        public function disableShips():void
        {
            showShips = false;
        }

        private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
            // register sprite pool
            FlyingVehiclePool.initialize(MAX_SHIPS, GROWTH_VALUE);
            draw();
        }

        private function onRemoved(e:Event):void
        {
            removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
            if (timer) {
                timer.removeEventListener(TimerEvent.TIMER_COMPLETE, addShipHandler);
            }
        }

        private function draw():void
        {
            // set clipping, so ships don't appear in apartment
            this.clipRect = new Rectangle(0, 0, this.windowWidth, this.windowHeight);
            // get bg - sky only - temp - whole thing
            cityBg = new Image(CityViewAssets.getAtlas().getTexture(BG));
            cityBg.width = 562;
            cityBg.height = 397;
            addChild(cityBg);
            //add rain
            _rain = new RainParticle();
            _rain.width = 200;
            _rain.height = 200;
            addChild(_rain);
            // get slums layer
            // get mid-region layer
            // get merit region layer
        }

        private function removeShip(ship:FlyingVehicle):void
        {
            // place sprite back in pool
            FlyingVehiclePool.disposeSprite(ship);
        }

        private function addShipHandler(e:TimerEvent):void
        {
            trace("called add ship handler");
            var num:uint = Global.getRandomNumber(1, 3);
            var dir:String;
            (num === 2) ? dir = Global.RIGHT : dir = Global.LEFT;
            trace("random number is: ", num);
            this.addShip(dir, num);
            triggerFlyingVehicle();
        }
    }
}