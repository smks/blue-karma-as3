package dialogue.character.slumsstreet.riley_bodyguards
{
    import assets.CharacterDialogueMessageAssets;
	import levels.level1.part3.SlumsStreet;
	import starling.events.Event;

    import dialogue.character.repositories.SlumsStreetDialogueRepository;
    import dialogue.character.AbstractCharacterDialogue;
    import dialogue.plaques.Plaque;

    import global.Global;

    /**
     * ...
     * @author @shaun
     */
    public class RileyBodyguards extends AbstractCharacterDialogue
    {
        private var pabloMessageIds:Array = [2, 11, 14];
        private var jakeMessageIds:Array = [5, 7, 8, 9, 12, 13];
		private var act:SlumsStreet;
		
		private var madeChoice:Boolean = false;

        public function RileyBodyguards(convoId:String = "riley_bodyguards_1", act:SlumsStreet = null)
        {
            this.act = act;
			setConvoId(convoId);			
            super();
        }

        override protected function drawDialogue():void
        {
            addDialogueBackground();
            addPlaques(Plaque.RILEY, Plaque.PABLO, Plaque.JAKE);
            addDialogueRepo();
        }

        override protected function composeDialogue():void
        {
            handleConversation();
        }

        override protected function showNextMessage():void
        {
            if (Global.inArray(_messageCounter, pabloMessageIds)) {
                if (!_rightPlaque.visible) {
                    toggleRightPlaque();
                }
            } else if (Global.inArray(_messageCounter, jakeMessageIds)) {
                if (_rightPlaque.visible) {
                    toggleRightPlaque();
                }
            }
			
			if (_messageCounter === 15 && madeChoice === false) {
				promptDecision();
				return;
			}
			
            super.showNextMessage();
        }
		
		override protected function yesChosen(e:starling.events.Event):void 
		{
			decisionMade();
		}
		
		override protected function noChosen(e:starling.events.Event):void 
		{
			if (act !== null) {
				act.getActScore().addToScore(
					'Wise man', 
					act.getActScore().getBonusAct().WISE_MAN, 
					act.getActScore().getBonusAct().WISE_MAN_SENTENCE, 
					act.getActScore().TYPE_BONUS
				);
			}
			
			decisionMade();
		}
		
		override protected function decisionMade():void 
		{
			this.madeChoice = true;
			
			removeDecisions();
			
			super.decisionMade();
		}
		
		override protected function promptDecision():void 
		{
			super.promptDecision();
			
			// We want him to choose whether to go in or not
			addDecisionButtons();
			
		}

        protected function handleConversation():void
        {
            fetchMessages();
            showNextMessage();
            handleConversationFlow();
        }

        private function addDialogueRepo():void
        {
            _repo = new SlumsStreetDialogueRepository(_convoId);
        }
    }
}