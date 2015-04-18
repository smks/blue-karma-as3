package assets
{
    import flash.utils.ByteArray;

    /**
     * ...
     * @author Shaun Stone
     */
    public class MessageBoxAssets
    {
        //targets available (characters)
        public static const ItemA:String = "item-a";
        public static const ItemB:String = "item-b";
        public static const ItemC:String = "item-c";
        public static const ItemD:String = "item-d";
        public static const BARRY:String = "barry";
        public static const BILLY:String = "billy";
        public static const CHARLIE:String = "charlie";
        public static const DANNY:String = "danny";
        public static const JAKWOB:String = "jakwob";
        public static const PABLO:String = "pablo";
        public static const RUPERT:String = "rupert";
        //targets available (props)
        public static const DOGBOB:String = "dog-bob";
        public static const CCTV1:String = "cctv1";
        public static const CCTV2:String = "cctv2";
        public static const FENCE_DOOR:String = "fence-door";
        //items available
        public static const NEWSPAPER1:String = "newspaper1";
        public static const BINBAG1:String = "binbag";
        //messages xml for level 1 slums - streets
        [Embed(source="../../../media/xml/level1/3-slums-street/messages.xml", mimeType="application/octet-stream")]
        private static var level1SlumsMessagesXML:Class;
        //XML
        private static var messagesData:XML;

        public static function getXMLData(name:String):XML
        {
            if (messagesData == null) {
                if (name == "Level-1") {
                    var byteArray:ByteArray = new level1SlumsMessagesXML() as ByteArray;
                    var data:XML = new XML(byteArray.readUTFBytes(byteArray.length));
                    messagesData = data;
                }
                return messagesData;
            }
            return messagesData;
        }
    }
}