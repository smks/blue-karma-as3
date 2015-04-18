package players.riley
{
    import assets.PlayerAssets;

    import starling.core.Starling;
    import starling.display.MovieClip;
    import starling.display.Sprite;
    import starling.events.Event;

    /**
     * ...
     * @author Shaun Stone
     */
    public class RileySittingVehicle extends Sprite
    {
        private const SITTING:uint = 0;
        protected var _rileySeated:MovieClip;
        protected var _rileyLookOutWindow:MovieClip;
        protected var _rileyLookAtDriver:MovieClip;
        private var _currentState:uint;

        public function RileySittingVehicle()
        {
            this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

		private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            createPlayerFrames();
            addPlayerFrames();
        }
		
        protected function createPlayerFrames():void
        {
            //Create player movieclip for standing facing the screen
            _rileySeated = new MovieClip(PlayerAssets.getAtlas(PlayerAssets.RILEY_SITTING).getTextures(PlayerAssets.RILEY_SITTING), 6);
            _rileySeated.x = 191;
            _rileySeated.y = 143;
            _rileySeated.setFrameDuration(0, 3);
            Starling.juggler.add(_rileySeated);
        }

        private function addPlayerFrames():void
        {
            // animations by default
            addChild(_rileySeated);
        }

        private function hideRileySeated():void
        {
            _rileySeated.stop();
            _rileySeated.visible = false;
        }
    }
}