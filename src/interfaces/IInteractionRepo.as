package interfaces
{
    /**
     * ...
     * @author Shaun Stone
     */
    public interface IInteractionRepo
    {
        function getMessages(objectId:String, objectType:String, interactionType:String):XMLList

        function getVoiceFiles(objectId:String, objectType:String, interactionType:String):XMLList;
    }
}