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
     * @author Shaun Stone - Blue Karma
     */
    public class Level1Assets
    {
        public static const SLUMSBACKGROUNDIMAGE:String = "SlumsBackgroundImage";
        public static const SLUMSBACKGROUNDTIMESTWOIMAGE:String = "SlumsBackgroundTimesTwoImage";
        public static const SLUMSSMALLALLEYBACKGROUNDIMAGE:String = "SlumsSmallAlleyBackgroundImage";
        public static const SLUMSALLEYWAYBACKGROUNDIMAGE:String = "SlumsAlleywayBackgroundImage";
        public static const SLUMSSTREETMETALFENCE:String = "metal_fence";
        public static const SLUMSSTREETMETALFENCEDOOROPEN:String = "metal_fence_door_open";
        public static const SLUMSSTREETMETALFENCEDOORSHUT:String = "metal_fence_door_shut";
        public static const SLUMSSTREETCAR1:String = "SlumsStreetCar1";
        public static const SLUMSSTREETCAR2:String = "SlumsStreetCar2";
        public static const SLUMSSTREETALLEYONE:String = "alley-1";
        public static const SLUMSSTREETCOMPOUNDDOOR:String = "compound-door";
        public static const SLUMSSTREETFUSEBOX:String = "fuse-box";
        public static const SLUMSSTREETFUSEBOXOPEN:String = "fuse-box-open";
        public static const SLUMSSTREETFUSEBOXSWITCHGREENON:String = "fuse-box-switch-green-on";
        public static const SLUMSSTREETFUSEBOXSWITCHGREENOFF:String = "fuse-box-switch-green-off";
        public static const SLUMSSTREETFUSEBOXSWITCHREDON:String = "fuse-box-switch-red-on";
        public static const SLUMSSTREETFUSEBOXSWITCHREDOFF:String = "fuse-box-switch-red-off";
        public static const SLUMSSTREETHOUSEDOOR:String = "house-door";
        public static const SLUMSSTREETHOUSEWINDOW:String = "house-window";
        public static const SLUMSSTREETROADSIGN:String = "road-sign";
        public static const SLUMSALLEYSKIPOPEN:String = "SlumsAlleySkipOpen";
        public static const SLUMSALLEYSKIPCLOSED:String = "SlumsAlleySkipClosed";
        public static const SLUMSALLEYBINS:String = "SlumsAlleyBins";
        public static const SLUMSFOREGROUNDLIGHTSON:String = "SlumsForegroundLightsOn";
        public static const SLUMSFOREGROUNDLIGHTSOFF:String = "SlumsForegroundLightsOff";
        public static const SLUMSFOREGROUNDSTREETLIGHTON:String = "SlumsForegroundStreetLightsOn";
        public static const SLUMSFOREGROUNDSTREETLIGHTOFF:String = "SlumsForegroundStreetLightsOff";
        public static const SLUMSFOREGROUNDSTREETLIGHT_LIGHT:String = "SlumsForegroundStreetLightLight";
        //create a dictionary class
        [Embed(source="../../../media/images/slums-street/SlumsStreet.png")]
        public static const SlumsStreetTextureAtlas:Class;
        //create an atlas class
        [Embed(source="../../../media/images/slums-street/SlumsStreet.xml", mimeType="application/octet-stream")]
        public static const SlumsStreetTextureAtlasXML:Class;
        //overlay for bg's
        [Embed(source="../../../media/images/slums-street/foregrounds/bins.png")]
        public static const SlumsAlleyBins:Class;
        /*
         * Alley 1 Props
         */
        [Embed(source="../../../media/images/slums-street/foregrounds/foreground-lights-on.png")]
        public static const SlumsForegroundLightsOn:Class;
        [Embed(source="../../../media/images/slums-street/foregrounds/slums-street-lamp.png")]
        public static const SlumsForegroundStreetLightsOff:Class;
        //Get Slums street Foreground
        [Embed(source="../../../media/images/slums-street/foregrounds/slums-street-lamp-on.png")]
        public static const SlumsForegroundStreetLightsOn:Class;
        [Embed(source="../../../media/images/slums-street/foregrounds/streetlight-light.png")]
        public static const SlumsForegroundStreetLightLight:Class;
        [Embed(source="../../../media/images/slums-street/backgrounds/slums_street_background_2.jpg")]
        //[Embed(source = "../../../media/images/slums-street/backgrounds/slums_street_background.jpg")]
        public static const SlumsBackgroundTimesTwoImage:Class;
        /**
         * Get Backgrounds
         *
         */

        //Get Slums street Bg
        //[Embed(source = "../../../media/images/slums-street/backgrounds/slumsBackground.png")]
        [Embed(source="../../../media/images/slums-street/backgrounds/slums_street_background.jpg")]
        public static const SlumsBackgroundImage:Class;
        private static var gameTextures:Dictionary = new Dictionary();
        private static var gameTextureAtlas:TextureAtlas;

        public static function getAtlas():TextureAtlas
        {
            if (gameTextureAtlas == null) {
                var texture:Texture = getTexture("SlumsStreetTextureAtlas");
                var xml:XML = XML(new SlumsStreetTextureAtlasXML());
                //create a new atlas
                gameTextureAtlas = new TextureAtlas(texture, xml);
            }
            //return atlas
            return gameTextureAtlas;
        }

        //get items
        public static function getTexture(name:String):Texture
        {
            if (gameTextures[name] == undefined) {
                var bitmap:Bitmap = new Level1Assets[name]();
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