package interactive.apartment.props.bedroom
{
    import assets.RileyApartmentAssets;

    import interactive.base.Prop;

    import starling.display.Image;

    /**
     * ...
     * @author Shaun Stone
     */
    public class BedroomWashingBasket extends Prop
    {
        private var _washingBasketOpen:Image;
        private var _washingBasketClosed:Image;
        private var _basketOpen:Boolean = false;

        public function BedroomWashingBasket(id:String, examinable:Boolean = false)
        {
            super(id, examinable);
            
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            if (_basketOpen) {
                closeWashingBasket();
                setBasketOpen(false);
            } else {
                openWashingBasket();
                setBasketOpen(true);
            }
        }

        override protected function getPropAsset(id:String):void
        {
            var washingBasketClosedName:String = RileyApartmentAssets.BEDROOM_WASHING_BASKET_CLOSED;
            var washingBasketOpenName:String = RileyApartmentAssets.BEDROOM_WASHING_BASKET_OPEN;
            _washingBasketClosed = new Image(RileyApartmentAssets.getAtlas().getTexture(washingBasketClosedName));
            addChild(_washingBasketClosed);
            _washingBasketOpen = new Image(RileyApartmentAssets.getAtlas().getTexture(washingBasketOpenName));
            addChild(_washingBasketOpen);
            _washingBasketOpen.visible = false;
        }

        public function openWashingBasket():void
        {
            _washingBasketClosed.visible = false;
            _washingBasketOpen.visible = true;
        }

        public function closeWashingBasket():void
        {
            _washingBasketClosed.visible = true;
            _washingBasketOpen.visible = false;
        }

        public function getBasketOpen():Boolean
        {
            return _basketOpen;
        }

        public function setBasketOpen(value:Boolean):void
        {
            _basketOpen = value;
        }

        public function isOpen():Boolean
        {
            if (_basketOpen) {
                return true;
            }
            return false;
        }
    }
}