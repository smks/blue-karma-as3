package bluekarma.interactive.base
{
    import bluekarma.interactive.base.InteractionObject;

    import starling.display.MovieClip;
    import starling.display.Sprite;
    import starling.events.Event;

    /**
     * ...
     * @author Shaun Stone
     *
     * Abstract class for characters
     */
    public class Character extends InteractionObject
    {
        public var _object:MovieClip;
        private var beenExamined:Boolean = false;

        /**
         *
         * @param    _name
         * @param    _talkable
         */
        public function Character(id:String, talkable:Boolean = false, examinable:Boolean = false)
        {
            _id = id;
            _talkable = talkable;
            _examinable = examinable;
            _type = "characters";
            drawCharacter();
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        override public function triggerChat(params:Object = null):void
        {
            super.triggerChat();
            var messageList:Array = _repo.getMessages(this._id, _type, _repo.CHAT);
            var voiceFiles:Array = _repo.getVoiceFiles(this._id, _type, _repo.CHAT);
            var voiceList:Array = new Array();
            for (var i:uint; i < voiceFiles.length; i++) {
                voiceList.push(_repo.getVoiceFile(voiceFiles[i]));
            }
            dispatchEventWith("messageListener", true, {messages: messageList, voices: voiceList});
        }

        override public function triggerExamine(params:Object = null):void
        {
            this.beenExamined = true;
            super.triggerExamine(params);
        }

        public function hasBeenExamined():Boolean
        {
            return beenExamined;
        }

        protected function drawCharacter():void
        {
            trace("drawing character" + id);
        }

        protected function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
        }
    }
}