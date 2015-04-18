package interactive.slumsstreet.props
{
    import assets.Level1Assets;

    import bluekarma.interactive.base.InteractionRepoFactory;

    import interactive.base.Prop;

    import starling.display.Image;

    /**
     * ...
     * @author @shaun
     */
    public class FuseBox extends Prop
    {
        private var fuseBoxOpen:Image;
        private var fuseBoxClosed:Image;
        private var fuseBoxSwitchGreenOn:Image;
        private var fuseBoxSwitchGreenOff:Image;
        private var fuseBoxSwitchRedOn:Image;
        private var fuseBoxSwitchRedOff:Image;
        private var open:Boolean = false;
        private var images:Array = new Array();
        private var lightsOn:Boolean = true;

        public function FuseBox(id:String, examinable:Boolean = false)
        {
            super(id, examinable);
            
        }

        override protected function getPropAsset(id:String):void
        {
            fuseBoxOpen = new Image(Level1Assets.getAtlas().getTexture(Level1Assets.SLUMSSTREETFUSEBOXOPEN));
            fuseBoxOpen.y = -30;
            fuseBoxOpen.visible = false;
            images.push(addChild(fuseBoxOpen));
            fuseBoxSwitchGreenOn = new Image(Level1Assets.getAtlas().getTexture(Level1Assets.SLUMSSTREETFUSEBOXSWITCHGREENON));
            fuseBoxSwitchGreenOn.x = 17;
            fuseBoxSwitchGreenOn.y = 80;
            images.push(addChild(fuseBoxSwitchGreenOn));
            fuseBoxSwitchGreenOff = new Image(Level1Assets.getAtlas().getTexture(Level1Assets.SLUMSSTREETFUSEBOXSWITCHGREENOFF));
            fuseBoxSwitchGreenOff.x = 31;
            fuseBoxSwitchGreenOff.y = 91;
            images.push(addChild(fuseBoxSwitchGreenOff));
            fuseBoxSwitchRedOn = new Image(Level1Assets.getAtlas().getTexture(Level1Assets.SLUMSSTREETFUSEBOXSWITCHREDON));
            fuseBoxSwitchRedOn.x = 17;
            fuseBoxSwitchRedOn.y = 52;
            images.push(addChild(fuseBoxSwitchRedOn));
            fuseBoxSwitchRedOff = new Image(Level1Assets.getAtlas().getTexture(Level1Assets.SLUMSSTREETFUSEBOXSWITCHREDOFF));
            fuseBoxSwitchRedOff.x = 31;
            fuseBoxSwitchRedOff.y = 63;
            images.push(addChild(fuseBoxSwitchRedOff));
            fuseBoxClosed = new Image(Level1Assets.getAtlas().getTexture(Level1Assets.SLUMSSTREETFUSEBOX));
            images.push(addChild(fuseBoxClosed));
            turnOff();
        }

        override protected function getRepo():void
        {
            _repoId = InteractionRepoFactory.SLUMS_STREET;
            _repo = InteractionRepoFactory.getInteractionRepo(_repoId);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject(params);
        }

        public function openBox():void
        {
            fuseBoxClosed.visible = false;
            fuseBoxOpen.visible = true;
            setOpen(true);
        }

        public function closeBox():void
        {
            fuseBoxClosed.visible = false;
            fuseBoxOpen.visible = true;
            setOpen(false);
        }

        public function turnOn():void
        {
            setLightsOn(true);
            fuseBoxSwitchGreenOn.visible = true;
            fuseBoxSwitchGreenOff.visible = false;
            fuseBoxSwitchRedOn.visible = false;
            fuseBoxSwitchRedOff.visible = true;
        }

        public function turnOff():void
        {
            setLightsOn(false);
            fuseBoxSwitchGreenOn.visible = false;
            fuseBoxSwitchGreenOff.visible = true;
            fuseBoxSwitchRedOn.visible = true;
            fuseBoxSwitchRedOff.visible = false;
        }

        public function isOpen():Boolean
        {
            return open;
        }

        public function isLightsOn():Boolean
        {
            return lightsOn;
        }

        public function setLightsOn(val:Boolean):void
        {
            lightsOn = val;
        }

        private function setOpen(val:Boolean):void
        {
            open = val;
        }
    }
}