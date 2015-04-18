package bluekarma.interactive.base
{
    import flash.globalization.StringTools;
    import flash.media.Sound;

    /**
     * ...
     * @author Shaun Stone
     */
    public class InteractionRepo
    {
        public const PROP:String = "props";
        public const ITEM:String = "items";
        public const CHARACTER:String = "characters";
        public const THOUGHT:String = "thoughts";
        public const ACTION:String = "action";
        public const CHAT:String = "chat";
        public const EXAMINE:String = "examine";
        protected var _xml:XML;
        protected var _xmlList:XMLList;

        public function InteractionRepo()
        {
        }

        public function getMessage(objectId:String, objectType:String, interactionType:String):String
        {
            trace("getting a message - NAAAAAT");
            return "";
        }

        /**
         * Get a thought message and voice file
         *
         * @param    thoughtId
         * @return
         */
        public function getThoughtId(thoughtId:String):Array
        {
            var message:Array = new Array();
            message[0] = xmlListToArray(_xml.type[THOUGHT].message.(@id == thoughtId).text());
            return message;
        }

        public function getThoughtVoiceFile(thoughtId:String):Array
        {
            var voiceFile:Array = xmlListToArray(_xml.type[THOUGHT].message.(@id == thoughtId).@voicetrack);
            var l:uint = voiceFile.length;
            for (var i:uint; i < l; i++) {
                voiceFile[i] = String(voiceFile[i]);
            }
            return voiceFile;
        }

        /**
         * Get messages needed from object
         *
         * @param    objectId
         * @param    objectType
         * @param    interactionType
         * @return
         */
        public function getMessages(objectId:String, objectType:String, interactionType:String, currentState:String = "x"):Array
        {
            return xmlListToArray(_xml.type[objectType].object.(@name == objectId).interact[interactionType].message.text());
        }

        /**
         * Get voice files from object
         *
         * @param    objectId
         * @param    objectType
         * @param    interactionType
         * @return
         */
        public function getVoiceFiles(objectId:String, objectType:String, interactionType:String, currentState:String = "x"):Array
        {
            return xmlListToArray(_xml.type[objectType].object.(@name == objectId).interact[interactionType].message.@voicetrack);
        }

        public function getVoiceFile(voiceFileName:String):Sound
        {
            return new Sound;
        }

        public function getDefaultMessage():String
        {
            return _xml.type.none.message.text();
        }

        /**
         *
         * @param list
         * @return
         */
        public function xmlListToArray(list:XMLList):Array
        {
            var a:Array = [], i:String;
            for (i in list) {
                a[i] = list[i];
            }
            return a;
        }
    }
}