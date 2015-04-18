package interfaces
{
    public interface Switchable
    {
        function on():void;

        function off():void;

        function toggle():void;

        function isOn():Boolean;
    }
}