package interfaces
{
    import bluekarma.interactive.base.Item;

    /**
     * ...
     * @author Shaun Stone
     */
    public interface IInventory
    {
        function addItem(item:Item):void;

        function removeItem(item:String):Boolean;

        function countItems():uint;

        function closeMenu():void;

        function openMenu():void;

        function disableInventory():void;

        function enableInventory():void;
    }
}