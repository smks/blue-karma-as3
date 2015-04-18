package bluekarma.interactive.slumsstreet.repos
{
    import adobe.utils.CustomActions;

    import assets.dialogue.Level1DialogueAssets;

    import bluekarma.interactive.base.InteractionRepo;

    import flash.media.Sound;

    /**
     * ...
     * @author Shaun Stone
     */
    public class SlumsStreetInteractionRepo extends InteractionRepo
    {
        private var randomMessageObjects:Array = new Array(
                'cctv1', 'billy', 'charlie'
        );

        public function SlumsStreetInteractionRepo()
        {
            fetchData();
        }

        override public function getVoiceFile(voiceFileName:String):Sound //return sound
        {
            //store reference
            var voiceFile:Sound = Level1DialogueAssets.getVoiceFile(voiceFileName);
            //remove for garbage collection
            Level1DialogueAssets.disposeOfVoiceFile(voiceFileName);
            //return
            return voiceFile;
        }

        /**
         * Get messages needed from object
         * Slums street incorporates different states (state 1, state 2)
         * Falls back to generic state X if not found normal state
         *
         * @param    objectId
         * @param    objectType
         * @param    interactionType
         * @return
         */
        override public function getMessages(objectId:String, objectType:String, interactionType:String, currentState:String = "x"):Array
        {
            var messages:Array = xmlListToArray(_xml.type[objectType].object.(@name == objectId).interact[interactionType].state.(@id == currentState).message.text());
            if (messages.length > 0) {
                return messages;
            }
            return xmlListToArray(_xml.type[objectType].object.(@name == objectId).interact[interactionType].state.(@id == "x").message.text());
        }

        /**
         * Slums street incorporates different states (state 1, state 2)
         * Falls back to generic state X if not found normal state
         *
         * @param    objectId
         * @param    objectType
         * @param    interactionType
         * @param    state
         * @return
         */
        override public function getVoiceFiles(objectId:String, objectType:String, interactionType:String, currentState:String = "x"):Array
        {
            var messages:Array = xmlListToArray(_xml.type[objectType].object.(@name == objectId).interact[interactionType].state.(@id == currentState).message.@voicetrack)
            if (messages.length > 0) {
                return messages;
            }
            return xmlListToArray(_xml.type[objectType].object.(@name == objectId).interact[interactionType].state.(@id == "x").message.@voicetrack);
        }

        protected function fetchData():void
        {
            _xml = getXMLData();
            if (_xml == null) {
                throw new Error("XML was not created!");
            }
        }

        protected function getXMLData():XML
        {
            //fetch xml object from assets
            return Level1DialogueAssets.getXMLData(Level1DialogueAssets.SLUMS_STREET);
        }
    }
}