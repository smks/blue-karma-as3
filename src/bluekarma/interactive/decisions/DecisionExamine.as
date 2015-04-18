package decisions
{
    import interfaces.IDecision;

    import helpers.MessageBox;

    import states.GameState;

    /**
     * ...
     * @author Shaun Stone
     */
    public class DecisionExamine extends AbstractDecision implements IDecision
    {
        public function DecisionExamine(type:String, id:String, state:uint)
        {
            super(type, name, state);
        }

        override protected function processDecision():void
        {
            _messageBox = new MessageBox(_objectType, _objectId, "examine");
            addChild(_messageBox);
        }
    }
}