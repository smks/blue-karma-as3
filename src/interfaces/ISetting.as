package interfaces
{
    import starling.events.Event;

    /**
     *
     * @author Shaun Stone
     */
    public interface ISetting
    {
        function getCurrentPosition():uint;

        function setCurrentPosition(pos:uint):void;
    }
}