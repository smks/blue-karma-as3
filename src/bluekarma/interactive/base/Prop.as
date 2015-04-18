package interactive.base
{
    import flash.media.Sound;

    import bluekarma.interactive.base.InteractionObject;

    import starling.events.Event;

    /**
     * ...
     * @author Shaun Stone
     */
    public class Prop extends InteractionObject
    {
        //declare type of interaction object
        private static const TYPE:String = "props";

        public function Prop(id:String, examinable:Boolean = false)
        {
            _id = id;
            _examinable = examinable;
            _type = Prop.TYPE;
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        /**
         * No Props can be spoken to so return message "No"
         */
        override public function triggerChat(params:Object = null):void
        {
            var messageArray:Array = new Array();
            var voiceIdArray:Array = new Array();
            var voiceSounds:Array = new Array();
            messageArray = _repo.getThoughtId("no");
            voiceIdArray = _repo.getThoughtVoiceFile("no");
            var l:uint = voiceIdArray.length;
            for (var i:uint = 0; i < l; i++) {
                var voice:Sound = _repo.getVoiceFile(voiceIdArray[i]);
                voiceSounds[i] = voice;
            }
            dispatchEventWith("messageListener", true, {messages: messageArray[0], voices: voiceSounds});
        }

        protected function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            getPropAsset(_id);
        }

        protected function getPropAsset(id:String):void
        {
        }
    }
}