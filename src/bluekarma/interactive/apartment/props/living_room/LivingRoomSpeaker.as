package interactive.apartment.props.living_room
{
    import interactive.base.Prop;

    import starling.display.Image;

    import assets.RileyApartmentAssets;

    /**
     * ...
     * @author Shaun Stone
     */
    public class LivingRoomSpeaker extends Prop
    {
        public static const SPEAKER_LEFT:String = "living_room_speaker_left";
        public static const SPEAKER_RIGHT:String = "living_room_speaker_right";
        private var speaker:Image;

        public function LivingRoomSpeaker(id:String, _examinable:Boolean)
        {
            super(id, _examinable);
        }

        override protected function getPropAsset(id:String):void
        {
            var speakerName:String;
            if (id == SPEAKER_LEFT) {
                speakerName = RileyApartmentAssets.LIVING_ROOM_SPEAKER_LEFT;
            } else if (id == SPEAKER_RIGHT) {
                speakerName = RileyApartmentAssets.LIVING_ROOM_SPEAKER_RIGHT;
            } else {
                throw new Error("No speaker was found");
            }
            //create rug
            speaker = new Image(RileyApartmentAssets.getAtlas().getTexture(speakerName));
            //add to stage
            addChild(speaker);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject(params);
        }
    }
}