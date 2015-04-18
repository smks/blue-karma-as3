package interactive.apartment.props.bedroom
{
    import flash.media.Sound;

    import interactive.base.Prop;

    import starling.display.Image;

    import assets.RileyApartmentAssets;

    import starling.display.MovieClip;

    /**
     * ...
     * @author Shaun Stone
     */
    public class PlantPot extends Prop
    {
        private var plantPot:MovieClip;
        private var watered:Boolean = false;

        public function PlantPot(id:String, _examinable:Boolean)
        {
            super(id, _examinable);
            
        }

        override protected function getPropAsset(id:String):void
        {
            // @TODO var doorOpen:String = RileyApartmentAssets.DOOR_OPEN;
            var plantPotName:String = RileyApartmentAssets.BEDROOM_PLANTPOT;
            //create bed
            plantPot = new MovieClip(RileyApartmentAssets.getAtlas().getTextures(plantPotName));
            //add to stage
            addChild(plantPot);
        }

        override public function triggerExamine(params:Object = null):void
        {
            if (watered === true) {
                var messageArray:Array = new Array();
                var voiceIdArray:Array = new Array();
                var voiceSounds:Array = new Array();
                messageArray = _repo.getThoughtId("plant_watered");
                voiceIdArray = _repo.getThoughtVoiceFile("plant_watered");
                var l:uint = voiceIdArray.length;
                for (var i:uint = 0; i < l; i++) {
                    var voice:Sound = _repo.getVoiceFile(voiceIdArray[i]);
                    voiceSounds[i] = voice;
                }
                dispatchEventWith("messageListener", true, {messages: messageArray[0], voices: voiceSounds});
                return;
            }
            super.triggerExamine(params);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject(params);
        }

        public function getWatered():Boolean
        {
            return watered;
        }

        public function setWatered(value:Boolean):void
        {
            watered = value;
        }
    }
}