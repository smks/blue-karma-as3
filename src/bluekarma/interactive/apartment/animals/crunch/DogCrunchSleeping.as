package bluekarma.interactive.apartment.animals.crunch
{
    import bluekarma.interactive.base.Animal;

    import starling.events.Event;
    import starling.core.Starling;
    import starling.display.MovieClip;
    import starling.display.Sprite;

    import assets.AnimalAssets;

    import starling.textures.Texture;

    /**
     * ...
     * @author Shaun Stone
     */
    public class DogCrunchSleeping extends Animal
    {
        protected const SLEEPING:String = "sleeping";
        protected const AWAKE:String = "awake";
        protected var _object2:MovieClip;
        protected var counter:uint = 0;
        private var dogFed:Boolean = false;
        private var spokeTo:Boolean = false;

        public function DogCrunchSleeping(id:String, examinable:Boolean = false)
        {
            super(id, examinable);
        }

        override protected function drawAnimal():void
        {
            var dogAwakeSittingName:String = "crunch_awake_sitting";
            var dogSleeping:String = "crunch_sleep_sitting";
            //create _animal movieclip
            _object = new MovieClip(AnimalAssets.getAtlas().getTextures(dogAwakeSittingName), 12);
            _object.visible = true;
            //dog sleeping
            _object2 = new MovieClip(AnimalAssets.getAtlas().getTextures(dogSleeping), 30);
            _object2.visible = false;
            addChild(_object);
            addChild(_object2);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject();
            trace("Im not picking him up");
        }

        override public function triggerChat(params:Object = null):void
        {
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
            if (hasBeenFed()) {
                triggerChat();
            } else {
                super.triggerExamine();
            }
        }

        public function setUpAnimation():void
        {
            //add to juggler
            Starling.juggler.add(_object);
            Starling.juggler.add(_object2);
            _object.setFrameDuration(0, 3);
            _object2.setFrameDuration(19, 8);
            _object.play();
            _object2.stop();
            _object.addEventListener("complete", onCompleteAwakeState);
        }

        public function stopAnimation():void
        {
            _object.stop();
            _object2.stop();
            _object.removeEventListener("complete", onCompleteAwakeState);
        }

        public function startAnimation():void
        {
            _object.play();
            _object2.stop();
            _object.addEventListener("complete", onCompleteAwakeState);
        }

        public function setBeenFed(boolean:Boolean):void
        {
            dogFed = boolean;
        }

        public function hasBeenFed():Boolean
        {
            return dogFed;
        }

        public function getSpokeTo():Boolean
        {
            return spokeTo;
        }

        public function setSpokeTo(value:Boolean):void
        {
            spokeTo = value;
        }

        protected function changeDogState(state:String):void
        {
            switch (state) {
                case AWAKE:
                    _object.visible = true;
                    _object2.visible = false;
                    break;
                case SLEEPING:
                    _object.visible = false;
                    _object2.visible = true;
                    break;
                default:
                    break;
            }
        }

        private function onCompleteAwakeState(e:Event):void
        {
            if (counter < 5) {
                counter++;
                return;
            } else {
                //reset counter
                counter = 0;
                //remove listener
                _object.removeEventListener("complete", onCompleteAwakeState);
                //change state to sleeping
                changeDogState(SLEEPING);
                _object2.play();
                //add listener for sleeping animation
                _object2.addEventListener("complete", onCompleteSleepingState);
            }
        }

        private function onCompleteSleepingState(e:Event):void
        {
            //stop sleeping animation
            _object2.stop();
            //remove event listener
            _object2.removeEventListener("complete", onCompleteAwakeState);
            //change to awake animation
            changeDogState(AWAKE);
            //play the awake animation
            _object.play();
            //add listener again
            _object.addEventListener("complete", onCompleteAwakeState);
        }
    }
}