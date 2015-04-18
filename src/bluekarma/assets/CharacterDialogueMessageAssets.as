package assets
{
    import adobe.utils.CustomActions;

    import flash.utils.ByteArray;
    import flash.utils.Dictionary;

    import starling.events.Event;

    /**
     * ...
     * @author Shaun Stone
     */
    public class CharacterDialogueMessageAssets
    {
        /**
         * add all dialogue conversations here
         */
        public static const RILEY_TYRONE_1:String = "riley_tyrone_1";
        public static const RILEY_ALBERT_1:String = "riley_albert_1";
        public static const RILEY_ALBERT_2:String = "riley_albert_2";
        public static const RILEY_BODYGUARDS_1:String = "riley_bodyguards_1";
        public static const RILEY_RUPERT_1:String = "riley_rupert_1";
        public static const RILEY_ROGER_1:String = "riley_roger_1";
        public static const RILEY_GANG_1:String = "riley_gang_1";
        public static const RILEY_GANG_2:String = "riley_gang_2";
        public static const DAWSON_PABLO:String = "dawson_pablo";
        static public const RILEY_DAWSON_1:String = "riley_dawson_1";
        /**
         * Apartment Riley & Tyrone 1
         */
        [Embed(source="../../../media/xml/level1/1-apartment-intro/riley_tyrone_1.xml", mimeType="application/octet-stream")]
        private const Riley_Tyrone_1:Class;
        /**
         * Journey Riley & Albert 1
         */
        [Embed(source="../../../media/xml/level1/2-albert-journey/riley_albert_1.xml", mimeType="application/octet-stream")]
        private const Riley_Albert_1:Class;
        /**
         * Compound Riley & Albert 2
         */
        [Embed(source="../../../media/xml/level1/5-compound/dialogue/riley_albert_2.xml", mimeType="application/octet-stream")]
        private const Riley_Albert_2:Class;
        /**
         * Bodyguard conversation at Compound
         */
        [Embed(source="../../../media/xml/level1/3-slums-street/dialogue/riley_bodyguards_1.xml", mimeType="application/octet-stream")]
        private const Riley_Bodyguards_1:Class;
        /**
         * Roger conversation at Slums Street
         *
         * "Better the lives of many"
         *
         */
        [Embed(source="../../../media/xml/level1/3-slums-street/dialogue/riley_rupert.xml", mimeType="application/octet-stream")]
        private const Riley_Rupert_1:Class;
        /**
         * Dawson and Paulo conversation in Compound
         */
        [Embed(source="../../../media/xml/level1/5-compound/dialogue/dawson_pablo.xml", mimeType="application/octet-stream")]
        private const Dawson_Pablo_1:Class;
        /**
         * Riley and Dawson conversation in Compound
         */
        [Embed(source="../../../media/xml/level1/5-compound/dialogue/riley_dawson.xml", mimeType="application/octet-stream")]
        private const Riley_Dawson_1:Class;
        /**
         * Dictionary to store more messages
         */
        private static var _dialogueDictionary:Dictionary;
        private var _convoId:String;
        private var _xml:XML;

        public function CharacterDialogueMessageAssets(convoId:String):void
        {
            _convoId = convoId;
            _xml = getXMLData();
        }

        /**
         * Free memory up when finished
         */
        public static function cleanUpMemory():void
        {
            if (_dialogueDictionary === null) {
                return;
            }
            for (var i:String in _dialogueDictionary) {
                _dialogueDictionary[i].dispose();
            }
        }

        public function getXMLData():XML
        {
            if (_dialogueDictionary === null) {
                _dialogueDictionary = new Dictionary();
            }
            if (_dialogueDictionary[_convoId] !== undefined) {
                return _dialogueDictionary[_convoId];
            }
            var tempXML:XML;
            trace(_convoId);
            switch (_convoId) {
                case RILEY_TYRONE_1:
                    tempXML = returnXMLData(_convoId, Riley_Tyrone_1);
                    break;
                case RILEY_ALBERT_1:
                    tempXML = returnXMLData(_convoId, Riley_Albert_1);
                    break;
                case RILEY_ALBERT_2:
                    tempXML = returnXMLData(_convoId, Riley_Albert_2);
                    break;
                case RILEY_BODYGUARDS_1:
                    tempXML = returnXMLData(_convoId, Riley_Bodyguards_1);
                    break;
                case RILEY_RUPERT_1:
                    tempXML = returnXMLData(_convoId, Riley_Rupert_1);
                    break;
                case DAWSON_PABLO:
                    tempXML = returnXMLData(_convoId, Dawson_Pablo_1);
                    break;
                case RILEY_DAWSON_1:
                    tempXML = returnXMLData(_convoId, Riley_Dawson_1);
                    break;
                default:
                    throw new Error("_convoId Not found");
            }
            if (tempXML) {
                return _dialogueDictionary[_convoId] = tempXML;
            }
            throw new Error("XML wasn't set");
        }

        private function returnXMLData(_convoId:String, className:Class):XML
        {
            var byteArray:ByteArray = new className() as ByteArray;
            var data:XML = new XML(byteArray.readUTFBytes(byteArray.length));
            return data;
        }
    }
}