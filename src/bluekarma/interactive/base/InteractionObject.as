package bluekarma.interactive.base
{
    import flash.display.Bitmap;
    import flash.media.Sound;
	import global.Global;
	import starling.filters.BlurFilter;

    import interfaces.IInteractionObject;

    import starling.display.MovieClip;
    import starling.display.Sprite;

    import flash.geom.Point;

    import starling.display.DisplayObject;

    /**
     * ...
     * @author Shaun Stone
     */
    public class InteractionObject extends Sprite implements IInteractionObject
    {
        public var _type:String;
        public var _talkable:Boolean = false;
        public var _actionable:Boolean = false;
        public var _examinable:Boolean = false;
        protected var _repoId:String;
        protected var _repo:*;
        protected var _inProximity:Boolean = false;
        // determine if the player needs to be next to object to interact
        protected var _combinable:Boolean = false;
        // Only applies to items
        protected var _fetchSingleRandomMessage:Boolean = false;
        // vary the messages to one random message that are used for interaction object
        protected var _bitmapData:Bitmap;

        /**
         * @desc constructor empty
         */

        public function InteractionObject()
        {
            getRepo();
        }

        public var _id:String;
        public function get id():String
        {
            return _id;
        }

        public function set id(value:String):void
        {
            _id = value;
        }

        /**
         *
         * @param    localPoint
         * @param    forTouch
         * @return
         */

        public override function hitTest(localPoint:Point, forTouch:Boolean = false):DisplayObject
        {
            var target:DisplayObject = super.hitTest(localPoint, forTouch);
            return (forTouch && target != null ? this : target);
        }

        /**
         * @desc the main function called to action an item
         * @param    params
         *
         * examples:
         * params.currentState - trigger an object dependent on the state of level
         * params.playerPosition - x position to determine if player is near the object
         * params.* pass in anything necessary
         *
         */
        public function triggerInteractionObject(params:Object = null):void
        {
            if (params === null) {
                trace("No params passed to object: ", _id);
            }
            var messageArray:Array = new Array();
            var voiceIdArray:Array = new Array();
            var voiceSounds:Array = new Array();
            messageArray = _repo.getThoughtId("cant_do_that");
            voiceIdArray = _repo.getThoughtVoiceFile("cant_do_that");
            var l:uint = voiceIdArray.length;
            for (var i:uint = 0; i < l; i++) {
                var voice:Sound = _repo.getVoiceFile(voiceIdArray[i]);
                voiceSounds[i] = voice;
            }
            dispatchEventWith("messageListener", true, {messages: messageArray[0], voices: voiceSounds});
            trace("interaction object triggered and actioned", _id);
        }

        public function triggerAction(params:Object = null):void
        {
            if (!_actionable) {
                trace("not actionable", _id);
                return;
            }
            trace("interaction object triggered and actioned", _id);
        }

        public function triggerChat(params:Object = null):void
        {
            if (!_talkable) {
                trace("not talkable", _id);
                return;
            }
            trace("interaction object triggered and chatted", _id);
        }

        public function triggerExamine(params:Object = null):void
        {
            trace("trigger examine has been called");
            if (!_examinable) {
                trace("not examinable", _id);
                return;
            }
            // temp variables
            var msges:Array = _repo.getMessages(_id, _type, _repo.EXAMINE);
            var vcfiles:Array = _repo.getVoiceFiles(_id, _type, _repo.EXAMINE);
            // these will be final outcome
            var messageList:Array = new Array();
            var voiceFiles:Array = new Array();
            if (_fetchSingleRandomMessage) {
                trace("fetch single random message");
                // first get length of array
                var len:uint = msges.length;
                if (len > 1) {

                    //pluck a random message
                    var el:uint = Math.floor(getRandomNumber(0, len));
                    messageList.push(msges[el]);
                    voiceFiles.push(vcfiles[el]);
                } else {
                    messageList = msges;
                    voiceFiles = vcfiles;
                }
            } else {
                messageList = msges;
                voiceFiles = vcfiles;
            }
            trace("array is now: ", messageList.length);
            //get all sound objects associated with message
            var voiceList:Array = new Array();
            for (var i:uint; i < voiceFiles.length; i++) {
                voiceList.push(_repo.getVoiceFile(voiceFiles[i]));
            }
            trace("triggerExamine voice length", voiceList.length);
            trace("triggerExamine dispatching event", voiceList.length);
            dispatchEventWith("messageListener", true, {messages: messageList, voices: voiceList});
        }

        /**
         *
         * @param    min
         * @param    max
         * @return
         */
        public function getRandomNumber(min:uint, max:uint):uint
        {
            return min + int(Math.random() * (max + min));
        }

        public function getType():String
        {
            return _type;
        }

        /**
         *
         * @desc make interactive object examinable
         */
        public function setExaminable(val:Boolean):void
        {
            _examinable = val;
        }

        /**
         * @desc make interactive object talkable
         */

        public function setTalkable(val:Boolean):void
        {
            _talkable = val;
        }

        /**
         * @desc make interactive object pickable
         */

        public function setActionable(val:Boolean):void
        {
            _actionable = val;
        }

        public function getFetchSingleRandomMessage():Boolean
        {
            return _fetchSingleRandomMessage;
        }

        public function setFetchSingleRandomMessage(value:Boolean):void
        {
            _fetchSingleRandomMessage = value;
        }

        public function setTouchable(val:Boolean):void
        {
            this.touchable = val;
        }

        public function hide():void
        {
            this.visible = false;
        }

        public function show():void
        {
            this.visible = true;
        }

        /**
         * @param glow
         */
        public function setGlow(glow:Boolean = false):void
        {
			if (glow) {
				this.filter = BlurFilter.createGlow(Global.BLUE_KARMA_GLOW_YELLOW, 1, 4, 2);
			} else {
				this.filter = null;
			}
        }

        protected function getRepo():void
        {
            _repoId = InteractionRepoFactory.APARTMENT_1;
            _repo = InteractionRepoFactory.getInteractionRepo(_repoId);
        }
    }
}