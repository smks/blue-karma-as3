package assets
{
    import flash.display.Bitmap;
    import flash.utils.Dictionary;

    import starling.text.BitmapFont;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;
    import starling.text.TextField;

    /**
     * ...
     * @author Shaun Stone
     */
    public class GameAssets
    {
        public static const GRADIENTOVERLAYSLUMS:String = "GradientOverlaySlums";
        //create a dictionary class
        [Embed(source="../../../media/arrows/arrow.png")]
        public static const ArrowHint:Class;
        //create an atlases
        [Embed(source="../../../media/buttons/arrow1-up.png")]
        public static const ArrowGameButtonUp:Class;
        /*
         *
         * Get Generic Buttons
         *
         * */
        [Embed(source="../../../media/buttons/arrow1-down.png")]
        public static const ArrowGameButtonDown:Class;
        [Embed(source="../../../media/buttons/decision-wheel/decision-wheel.png")]
        public static const DecisionWheelAtlas:Class;
        [Embed(source="../../../media/buttons/decision-wheel/decision-wheel.xml", mimeType="application/octet-stream")]
        public static const DecisionWheelXML:Class;
        [Embed(source="/../media/images/instructions-menu/close_button.png")]
        public static const CloseButton:Class;
        /*
         *
         * Decision Wheel atlas
         *
         */
        [Embed(source="../../../media/overlays/overlay.png")]
        public static const Overlay:Class;
        [Embed(source="../../../media/overlays/overlay-50.png")]
        public static const Overlay50:Class;
        [Embed(source="/../media/images/slums-street/backgrounds/gradient_overlay_slum_streets.png")]
        public static const GradientOverlaySlums:Class;
        [Embed(source="../../../media/overlays/black.jpg")]
        public static const Fader:Class;
        private static var gameTextures:Dictionary = new Dictionary();
        private static var gameTextureAtlas:TextureAtlas;

        public static function getAtlas(name:String = null):TextureAtlas
        {
            if (gameTextureAtlas == null) {
                var texture:Texture = getTexture("DecisionWheelAtlas");
                var xml:XML = XML(new DecisionWheelXML());
                //create a new atlas
                gameTextureAtlas = new TextureAtlas(texture, xml);
            }
            //return atlas
            return gameTextureAtlas;
        }

        public static function getTexture(name:String):Texture
        {
            if (gameTextures[name] == undefined) {
                var bitmap:Bitmap = new GameAssets[name]();
                gameTextures[name] = Texture.fromBitmap(bitmap);
            }
            return gameTextures[name];
        }

        /**
         * Free memory up when finished
         */
        public static function cleanUpMemory():void
        {
            for (var i:String in gameTextures) {
                gameTextures[i].dispose();
            }
        }
    }
}