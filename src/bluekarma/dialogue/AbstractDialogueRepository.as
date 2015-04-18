package dialogue
{
    import assets.CharacterDialogueMessageAssets;
    import assets.MessageBoxAssets;

    import flash.media.Sound;

    /**
     * ...
     * @author Shaun Stone
     */
    public class AbstractDialogueRepository
    {
        protected var _convoId:String;
        protected var _messageList:XMLList;
        protected var _messageVoiceFilesList:XMLList;
        protected var _messageVoiceFiles:Array;
        private var speakersArray:Array;
        private var speakersList:XMLList;

        public function AbstractDialogueRepository(convoId:String)
        {
            if (convoId == null) {
                throw new Error("The Convo Id has to be passed in");
            }
            _convoId = convoId;
            prepareXMLObject();
        }

        protected var _xmlObject:XML;
        public function get xmlObject():XML
        {
            return _xmlObject;
        }

        protected var _messages:Array;
        public function set messages(value:Array):void
        {
            _messages = value;
        }

        protected var _assets:CharacterDialogueMessageAssets;
        public function get assets():CharacterDialogueMessageAssets
        {
            return _assets;
        }

        public function set assets(value:CharacterDialogueMessageAssets):void
        {
            _assets = value;
        }

        public function prepareXMLObject():void
        {
            if (_assets === null) {
                _assets = new CharacterDialogueMessageAssets(_convoId);
                _xmlObject = _assets.getXMLData();
                _xmlObject;
            }
        }

        public function findMessageVoiceFilesByConvoId():Array
        {
            if (_messageVoiceFiles == null || _messageVoiceFiles.length == 0) {
                _messageVoiceFiles = new Array();
                _messageVoiceFilesList = new XMLList();
                _messageVoiceFilesList = _xmlObject.conversation.message.@voicetrack;
                var _length:uint = _messageVoiceFilesList.length();
                for (var i:uint = 0; i < _length; i++) {
                    _messageVoiceFiles.push(_messageVoiceFilesList[i]);
                }
            }
            return _messageVoiceFiles;
        }

        public function findSpeakersByConvoId():Array
        {
            speakersArray = new Array();
            speakersList = new XMLList();
            speakersList = _xmlObject.conversation.message.@speaker;
            var _length:uint = speakersList.length();
            if (_length === 0) {
                throw new Error("Need to set speakers!");
            }
            for (var i:uint = 0; i < _length; i++) {
                speakersArray.push(speakersList[i]);
            }
            return speakersArray;
        }

        public function findMessagesByConvoId():Array
        {
            if (_messages == null || _messages.length == 0) {
                _messages = new Array();
                _messageList = new XMLList();
                _messageList = _xmlObject.conversation.message.text();
                var _length:uint = _messageList.length();
                for (var i:uint = 0; i < _length; i++) {
                    _messages.push(_messageList[i]);
                }
            }
            return _messages;
        }
    }
}