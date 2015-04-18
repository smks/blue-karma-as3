package bluekarma.settings.foregrounds
{
    import assets.CompoundAssets;
    import assets.GameAssets;
    import assets.Level1Assets;

    import settings.base.Foreground;

    import starling.display.BlendMode;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;

    /**
     * Class ForegroundCompound
     * @author Shaun M.K Stone (SMKS)
     * @website http://www.smks.co.uk
     * Created at: 08-01-2015 14:30:03
     */
    public class ForegroundCompound extends Foreground
    {
        public static const POSITION_1:Number = 1;
        private const BG_IMAGE_NAME:String = 'CompoundForegroundImage';
        private const BG_IMAGE_NAME_SHADE:String = 'CompoundForegroundShadeImage';
        /**
         * The image retrieved from Assets
         */
        private var bg:Image;
        private var shade:Image;
        private var gradient:Image;

        /**
         * Main Constructor of ForegroundCompound
         * @param params object - pass in properties
         */
        public function ForegroundCompound(position:uint = 1)
        {
            super(position);
        }

        /**
         * Compose all the variables before draw
         */
        override protected function composeSetting():void
        {
            drawSetting();
        }

        /**
         * Draw the setting
         */
        override protected function drawSetting():void
        {
            //add main foreground image
            bg = new Image(CompoundAssets.getTexture(BG_IMAGE_NAME));
            bg.y = Game.STAGE_HEIGHT - bg.height;
            addChild(bg);
            shade = new Image(CompoundAssets.getTexture(BG_IMAGE_NAME_SHADE));
			shade.scaleX = 4;
			shade.scaleY = 4;
            shade.blendMode = BlendMode.MULTIPLY;
            addChild(shade);
            gradient = new Image(GameAssets.getTexture("GradientOverlaySlums"));
			gradient.scaleX = 4;
			gradient.scaleY = 4;
            addChild(gradient);
            // set position
            setCurrentPosition(_currentPosition);
        }
    }
}