package settings.backgrounds.albertscar.movingbg
{
    import starling.display.Sprite;

    /**
     * ...
     * @author Shaun Stone
     */
    public class AbstractMovingBackground extends Sprite
    {
        public var speed:uint = 0;
        protected var debug:Boolean = false;

        public function AbstractMovingBackground(_speed:uint = 10, _debug:Boolean = false)
        {
            speed = _speed;
            debug = _debug;
        }

        protected function getRandomNumber(min:uint, max:uint):uint
        {
            return min + int(Math.random() * (max + min));
        }
    }
}