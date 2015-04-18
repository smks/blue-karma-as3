package dialogue.plaques
{
    import flash.utils.Dictionary;

    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;

    import assets.PlaqueAssets;

    /**
     * ...
     * @author Shaun Stone
     */
    public class Plaque extends Sprite
    {
        public static const RILEY:String = "riley";
        public static const RILEY_PYJAMAS:String = "riley_pyjamas";
        public static const TYRONE:String = "tyrone";
        public static const PRIVATE:String = "private";
        public static const JACK:String = "jack";
        public static const CARMEN:String = "carmen";
        public static const ALBERT:String = "albert";
        public static const JAKE:String = "jake";
        public static const PABLO:String = "pablo";
        public static const ROGER:String = "roger";
        public static const RUPERT:String = "rupert";
        public static const BILLY:String = "billy";
        public static const CHARLIE:String = "charlie";
        public static const DANNY:String = "danny";
        public static const UNKNOWN:String = "unknown";
        static public const DAWSON:String = "dawson";
        protected var _name:String;
        protected var _plaque:Image;

        public function Plaque(name:String)
        {
            _name = name;
            createPlaque();
        }

        private function createPlaque():void
        {
            _plaque = new Image(PlaqueAssets.getAtlas().getTexture(_name));
            addChild(_plaque);
        }
    }
}