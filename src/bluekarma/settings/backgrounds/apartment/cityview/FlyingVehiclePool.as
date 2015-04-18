package settings.backgrounds.apartment.cityview
{
    import global.Global;

    import starling.display.Sprite;

    /**
     * ...
     * @author @shaun
     */
    public final class FlyingVehiclePool
    {
        private static var MAX_VALUE:uint;
        private static var GROWTH_VALUE:uint;
        private static var counter:uint;
        private static var pool:Vector.<FlyingVehicle>;
        private static var currentSprite:FlyingVehicle;

        public static function initialize(maxPoolSize:uint, growthValue:uint):void
        {
            MAX_VALUE = maxPoolSize;
            GROWTH_VALUE = growthValue;
            counter = maxPoolSize;
            var i:uint = maxPoolSize;
            pool = new Vector.<FlyingVehicle>(MAX_VALUE);
            while (--i > -1) {
                pool[i] = new FlyingVehicle(Global.getRandomNumber(1, 12));
            }
        }

        public static function getShip():FlyingVehicle
        {
            if (counter > 0) {
                return currentSprite = pool[--counter];
            }
            var i:uint = GROWTH_VALUE;
            while (--i > -1) {
                pool.unshift(new FlyingVehicle(i));
            }
            counter = GROWTH_VALUE;
            return getShip();
        }

        public static function disposeSprite(disposedSprite:FlyingVehicle):void
        {
            pool[counter++] = disposedSprite;
        }

        static public function getPoolLength():uint
        {
            return pool.length;
        }
    }
}