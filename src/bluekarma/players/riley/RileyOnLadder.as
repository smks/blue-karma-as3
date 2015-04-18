package players.riley
{
    import assets.PlayerAssets;

    import global.Global;

    import interactive.base.Prop;

    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.MovieClip;
    import starling.display.Sprite;

    /**
     * @author @shaun
     */
    public class RileyOnLadder extends Prop
    {
        private var _rileyStandingOnLadder:MovieClip;
        private var _currentDir:String = Global.LEFT;

        public function RileyOnLadder(id:String, examinable:Boolean = false)
        {
            super(id, examinable);
            setTouchable(false);
            setExaminable(false);
        }

        /**
         *
         * @param id
         */
        override protected function getPropAsset(id:String):void
        {
            //Create player movieclip for standing facing the screen
            _rileyStandingOnLadder = new MovieClip(PlayerAssets.getAtlas(PlayerAssets.RILEY_STANDING_LADDER)
                    .getTextures(), 12);
            _rileyStandingOnLadder.setFrameDuration(0, 5);
            _rileyStandingOnLadder.setFrameDuration(4, 5);
            Starling.juggler.add(_rileyStandingOnLadder);
            _rileyStandingOnLadder.scaleX = 1;
            _rileyStandingOnLadder.scaleY = 1;
            _rileyStandingOnLadder.pivotX = _rileyStandingOnLadder.width / 2;
            _rileyStandingOnLadder.pivotY = _rileyStandingOnLadder.height / 2;
            addChild(_rileyStandingOnLadder);
            _rileyStandingOnLadder.play();
        }

        override public function hide():void
        {
            super.hide();
            if (_rileyStandingOnLadder !== null) {
                _rileyStandingOnLadder.stop();
            }
        }

        override public function show():void
        {
            super.show();
            if (_rileyStandingOnLadder !== null) {
                _rileyStandingOnLadder.play();
            }
        }

        /**
         *
         * @param string
         */
        public function changeDirection(direction:String = Global.LEFT):void
        {
            if (_currentDir === Global.LEFT && direction === Global.RIGHT) {
                _rileyStandingOnLadder.scaleX = -1;
            } else if (_currentDir === Global.RIGHT && direction === Global.LEFT) {
                _rileyStandingOnLadder.scaleX = 1;
            }
            setCurrentDir(direction);
        }

        public function getCurrentDir():String
        {
            return _currentDir;
        }

        public function setCurrentDir(value:String):void
        {
            _currentDir = value;
        }
    }
}