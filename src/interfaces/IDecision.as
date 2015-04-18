package interfaces
{
    /**
     * ...
     * @author Shaun Stone
     */
    public interface IDecision
    {
        function getObjectType():String;

        function getObjectId():String;

        function getState():uint;
    }
}