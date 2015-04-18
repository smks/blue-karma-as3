package assets
{
    import flash.display.Bitmap;
    import flash.utils.Dictionary;

    import starling.textures.Texture;

    /**
     * ...
     * @author Shaun Stone
     */
    public class NotificationsAssets
    {
        [Embed(source="../../../media/images/achievements/achievement-bg.jpg")]
        public static const AchievementBg:Class;
        [Embed(source="../../../media/images/notifications/bar-bg.png")]
        public static const ModalBg:Class;
        private static var notificationTextures:Dictionary = new Dictionary();

        public static function getTexture(name:String):Texture
        {
            if (notificationTextures[name] == undefined) {
                var bitmap:Bitmap = new NotificationsAssets[name]();
                notificationTextures[name] = Texture.fromBitmap(bitmap);
            }
            return notificationTextures[name];
        }

        /**
         * Free memory up when finished
         */
        public static function cleanUpMemory():void
        {
            for (var i:String in notificationTextures) {
                notificationTextures[i].dispose();
            }
        }
    }
}