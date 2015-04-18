package bluekarma.interactive.slumsstreet.animals
{
    import bluekarma.assets.sound.SoundAssets;
    import bluekarma.interactive.base.Animal;
    import bluekarma.interactive.base.InteractionRepoFactory;

    import starling.core.Starling;
    import starling.display.MovieClip;
    import starling.display.Sprite;

    import assets.AnimalAssets;

    /**
     * ...
     * @author Shaun Stone
     */
    public class DogBob extends Animal
    {
        public function DogBob(id:String, examinable:Boolean = false)
        {
            super(id, examinable);
            setTalkable(true);
        }

        override protected function drawAnimal():void
        {
            //create _animal movieclip
            _object = new MovieClip(AnimalAssets.getAtlas().getTextures("bobDog"), 12);
            Starling.juggler.add(_object);
            makeAnimalSound();
            _object.play();
            _object.x = 200;
            _object.y = 200;
            addChild(_object);
            _object.addEventListener("complete", onSoundComplete);
            _object.setFrameDuration(1, 0);
        }

        override protected function getRepo():void
        {
            _repoId = InteractionRepoFactory.SLUMS_STREET;
            _repo = InteractionRepoFactory.getInteractionRepo(_repoId);
        }

        /**
         * @TODO Not working
         */

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

        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject(params);
        }

        public function muteAnimal():void
        {
            _object.setFrameSound(6, null);
        }

        public function makeAnimalSound():void
        {
            _object.setFrameSound(6, SoundAssets.dogWoof);
        }
    }
}