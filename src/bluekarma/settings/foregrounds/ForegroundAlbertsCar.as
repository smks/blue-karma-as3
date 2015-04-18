package settings.foregrounds
{
    import assets.GameAssets;
    import assets.Level1Assets;

    import bluekarma.assets.settings.backgrounds.albertscar.AlbertJourneyAssets;

    import settings.AbstractSetting;
    import settings.base.Foreground;

    import starling.display.BlendMode;
    import starling.display.Image;

    /**
     * ...
     * @author Shaun Stone
     */
    public class ForegroundAlbertsCar extends Foreground
    {
        private var _fg:Image;
        private var _ambienceSet:Boolean;
		private var _fgShadow:Image;
		private var fgGlimmer:Image;

        public function ForegroundAlbertsCar(position:uint = 1)
        {
            super(position);
            composeSetting();
            drawSetting();
        }

        override protected function composeSetting():void
        {
            trace("composing setting");
        }

        /**
         * renders the graphics
         */
        override protected function drawSetting():void
        {
            _fg = new Image(AlbertJourneyAssets.getTexture("CarForeground"));
            addChild(_fg);
			
			_fgShadow = new Image(AlbertJourneyAssets.getTexture("CarForegroundShadow"));
            addChild(_fgShadow);
			
			fgGlimmer = new Image(AlbertJourneyAssets.getAtlas().getTexture("glimmer"));
			fgGlimmer.alpha = 0.5;
			fgGlimmer.scaleX = 4;
			fgGlimmer.scaleY = 4;
			addChild(fgGlimmer);
			
            // apply multiply blend mode
            _fgShadow.blendMode = BlendMode.MULTIPLY;
            var filter:Image = new Image(GameAssets.getTexture("GradientOverlaySlums"));
			filter.scaleX = 4;
			filter.scaleY = 4;
            addChild(filter);
        }

        override public function setCurrentPosition(position:uint):void
        {
            //position will always be the same
            return;
        }

        /**
         * Only call once to set
         * @param    type
         */
        public function setAmbience(type:String):void
        {
            if (_ambienceSet) {
                return;
            }
            switch (type) {
                case "slums" :
                    return;
                    break;
                case "mid-region" :
                    return;
                    break;
                case "merits" :
                    return;
                    break;
            }
            _ambienceSet = true;
        }
    }
}