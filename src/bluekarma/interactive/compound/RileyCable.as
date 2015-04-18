package bluekarma.interactive.compound
{
    import assets.Level1CharacterAssets;
    import assets.RileyCableAssets;

    import bluekarma.interactive.base.InteractionRepoFactory;

    import starling.display.MovieClip;
    import starling.display.Image;
    import starling.core.Starling;
    import starling.display.Sprite;
    import starling.events.Event;

    /**
     * Interactive Character: RileyCable
     * @author Shaun Stone
     * Created at: 22-02-2015 13:31:48
     */
    public class RileyCable extends Sprite
    {
        /**
         * The Character asset name for RileyCable
         * @param rileycable
         */
        public static const ASSET_NAME:String = "rileycable";
        /**
         * The Character Sprite or Movieclip
         * @param character
         */
        private var riley:MovieClip;
        /*
         * Main Constructor, override any default properties here
         */
        public function RileyCable()
        {
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        public function setFrameRate(fps:uint):void
        {
            if (fps < 1) {
                fps = 1;
            }
            if (fps > 12) {
                fps = 12;
            }
            riley.fps = Math.floor(fps);
        }

        public function getFps():Number
        {
            return riley.fps;
        }

        public function stop():void
        {
            riley.stop();
        }
		
		public function getMovieclip():MovieClip 
		{
			return riley;
		}

        /**
         * Get the character Assets and draw either a Sprite
         * Or a Movieclip, if the latter; add to the Juggler
         * and add to the container
         */
        protected function drawCharacter():void
        {
            // Create a Movieclip with animation - shown by default
            riley = new MovieClip(RileyCableAssets.getAtlas().getTextures(RileyCableAssets.ASSET_NAME), 20);
            riley.scaleX = 1.4;
            riley.scaleY = 1.4;
            // character.setFrameDuration(0, 2);
            addChild(riley);
            Starling.juggler.add(riley);
            riley.play();
        }

        private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            drawCharacter();
        }
    }
}