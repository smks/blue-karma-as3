package bluekarma.gui.phone.health
{
    import assets.InventoryAssets;

    import global.Global;

    import gui.inventory.PhoneMenu;
    import gui.inventory.Validator;

    import starling.display.Image;
    import starling.display.Quad;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.text.TextField;
    import starling.textures.Texture;
    import starling.utils.HAlign;

    /**
     * Class HealthMenu
     * @author Shaun M.K Stone (SMKS)
     * @desc
     * @website http://www.smks.co.uk
     * Created at: 07-01-2015 10:14:10
     */
    public class HealthMenu extends Sprite
    {
        /**
         * params passed into health menu
         */
        private var heartRate:uint;
        private var oxygenLevel:uint;
        private var bloodPressureSys:uint;
        private var bloodPressureDys:uint;
        private var bloodCount:uint;
        private var currentMembership:String;
        private var membershipExp:String;
        private var bg:Quad;
        private var healthStatsLabel:TextField;
        private var rfidStrengthLabel:TextField;
        private var currentMemberShipLabel:TextField;
        private var membershipExpiresLabel:TextField;
        private var statBPM:TextField;
        private var statO2:TextField;
        private var statBP:TextField;
        private var statBC:TextField;
        private var bpmIcon:Image;
        private var o2Icon:Image;
        private var bpIcon:Image;
        private var bcIcon:Image;
        private var header:Quad;
        private var membershipFooter:Quad;
        /**
         * The movieclip of images retrieved from Assets
         */
        //private var animation:MovieClip;
        private var memExpiryFooter:Quad;

        /**
         * Main Constructor
         * @param p object - pass in params
         */
        public function HealthMenu(p:Object)
        {
            // check to make sure they all get passed through
            Validator.checkHealthMenuParams(p);
            this.heartRate = p.heartRate;
            this.oxygenLevel = p.oxygenLevel;
            this.bloodCount = p.bloodCount;
            this.bloodPressureSys = p.bloodPressureSys;
            this.bloodPressureDys = p.bloodPressureDys;
            this.currentMembership = p.currentMembership;
            this.membershipExp = p.membershipExp;
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        /**
         * The inventory clock calls this on every iteration
         * to update already set values and randomly changes values
         *
         * @param    heartRate
         * @param    oxygenLevel
         * @param    bloodPressureSys
         * @param    bloodPressureDys
         * @param    bloodCount
         */
        public function updateHealthStats():void
        {
            this.statBPM.text = setHeartRate(Global.getRandomNumber(heartRate - 5, heartRate + 5));
            if (oxygenLevel >= 99) {
                oxygenLevel = 98;
            }
            if (oxygenLevel < 90) {
                oxygenLevel = 90;
            }
            this.statO2.text = setOxygenLevel(Global.getRandomNumber(oxygenLevel - 2, oxygenLevel + 2));
            this.statBP.text = setBloodPressure(
                    Global.getRandomNumber(bloodPressureSys - 2, bloodPressureSys + 2),
                    Global.getRandomNumber(bloodPressureDys - 2, bloodPressureDys + 2)
            );
            this.statBC.text = setBloodCount(
                    Global.getRandomNumber(bloodCount - 100, bloodCount + 100)
            );
        }

        /**
         *
         * @param state
         */
        public function setState(state:String):void
        {
            var newHeartRate:uint;
            var newOxygen:uint;
            var newBPSys:uint;
            var newBPDys:uint;
            var newBc:uint = bloodCount; // @todo change after research
            switch (state) {
                case PhoneMenu.FINE :
                    newHeartRate = 65;
                    newOxygen = 98;
                    newBPSys = 120;
                    newBPDys = 80;
                    newBc = bloodCount;
                    break;
                case PhoneMenu.UNEASY :
                    newHeartRate = 95;
                    newOxygen = 98;
                    newBPSys = 140;
                    newBPDys = 95;
                    newBc = bloodCount;
                    break;
                case PhoneMenu.TERRIFIED :
                    newHeartRate = 150;
                    newOxygen = 98;
                    newBPSys = 150;
                    newBPDys = 100;
                    newBc = bloodCount;
                    break;
            }
            this.statBPM.text = setHeartRate(Global.getRandomNumber(newHeartRate - 5, newHeartRate + 5));
            if (newOxygen >= 99) {
                newOxygen = 98;
            }
			
            this.statO2.text = setOxygenLevel(Global.getRandomNumber(newOxygen - 2, newOxygen + 2));
            this.statBP.text = setBloodPressure(
                    Global.getRandomNumber(newBPSys - 2, newBPSys + 2),
                    Global.getRandomNumber(newBPDys - 2, newBPDys + 2)
            );
            this.statBC.text = setBloodCount(
                    Global.getRandomNumber(newBc - 100, newBc + 100)
            );
        }

        /**
         * When added to the stage
         * @param e
         */
        private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            draw();
        }

        private function draw():void
        {

            // add BG
            bg = new Quad(380, 440, Global.BLUE_KARMA_BLACK);
            addChild(bg);
            header = new Quad(380, 70, Global.BLUE_KARMA_BLUE, true);
            addChild(header);
            membershipFooter = new Quad(380, 50, Global.BLUE_KARMA_GOLD, true);
            membershipFooter.y = 340
            addChild(membershipFooter);
            memExpiryFooter = new Quad(380, 50, Global.BLUE_KARMA_BLUE, true);
            memExpiryFooter.y = 390
            addChild(memExpiryFooter);
            addLabels();
            addIcons();
            addValues();
        }

        private function addLabels():void
        {
            healthStatsLabel = new TextField(200, 70, "HEALTH STATS", Global.DEFAULT_FONT, 26, Global.BLUE_KARMA_WHITE, true);
            //healthStatsLabel.border = true;
            healthStatsLabel.hAlign = HAlign.CENTER;
            addChild(healthStatsLabel);
            rfidStrengthLabel = new TextField(160, 70, "RFID STRENGTH: 95%", Global.DEFAULT_FONT, 14, Global.BLUE_KARMA_WHITE, true);
            //rfidStrengthLabel.border = true;
            rfidStrengthLabel.hAlign = HAlign.CENTER;
            rfidStrengthLabel.x = 220;
            addChild(rfidStrengthLabel);
            currentMemberShipLabel = new TextField(380, 50, "CURRENT MEMBERSHIP: " + String(currentMembership).toUpperCase(), Global.DEFAULT_FONT, 16, Global.BLUE_KARMA_WHITE, true);
            //currentMemberShipLabel.border = true;
            currentMemberShipLabel.hAlign = HAlign.CENTER;
            currentMemberShipLabel.y = 340;
            addChild(currentMemberShipLabel);
            membershipExpiresLabel = new TextField(380, 50, "Date of Renewal: " + membershipExp, Global.DEFAULT_FONT, 16, Global.BLUE_KARMA_WHITE, true);
            //membershipExpiresLabel.border = true;
            membershipExpiresLabel.hAlign = HAlign.CENTER;
            membershipExpiresLabel.y = 390;
            addChild(membershipExpiresLabel);
        }

        private function addIcons():void
        {
            // ADD HEART
            var heartTexture:Texture = InventoryAssets.getAtlas("mainMenu").getTexture("bpm");
            var o2Texture:Texture = InventoryAssets.getAtlas("mainMenu").getTexture("o2");
            var bpTexture:Texture = InventoryAssets.getAtlas("mainMenu").getTexture("bp");
            var bloodTexture:Texture = InventoryAssets.getAtlas("mainMenu").getTexture("bc");
            bpmIcon = new Image(heartTexture);
            bpmIcon.x = 70;
            bpmIcon.y = 105;
            addChild(bpmIcon);
            // ADD O2
            o2Icon = new Image(o2Texture);
            o2Icon.x = 240;
            o2Icon.y = 105;
            addChild(o2Icon);
            // ADD BP
            bpIcon = new Image(bpTexture);
            bpIcon.x = 75;
            bpIcon.y = 220;
            addChild(bpIcon);
            // ADD BLOOD COUNT
            bcIcon = new Image(bloodTexture);
            bcIcon.x = 250;
            bcIcon.y = 220;
            addChild(bcIcon);
        }

        private function addValues():void
        {
            statBPM = new TextField(100, 30, this.setHeartRate(heartRate), Global.DEFAULT_FONT, 20, Global.BLUE_KARMA_WHITE, true);
            //statBPM.border = true;
            statBPM.x = 50;
            statBPM.y = 160;
            addChild(statBPM);
            statO2 = new TextField(100, 30, this.setOxygenLevel(oxygenLevel), Global.DEFAULT_FONT, 20, Global.BLUE_KARMA_WHITE, true);
            //statO2.border = true;
            statO2.x = 220;
            statO2.y = 160;
            addChild(statO2);
            statBP = new TextField(100, 30, this.setBloodPressure(bloodPressureSys, bloodPressureDys), Global.DEFAULT_FONT, 20, Global.BLUE_KARMA_WHITE, true);
            //statBP.border = true;
            statBP.x = 50;
            statBP.y = 280;
            addChild(statBP);
            statBC = new TextField(140, 30, this.setBloodCount(bloodCount), Global.DEFAULT_FONT, 20, Global.BLUE_KARMA_WHITE, true);
            //statBC.border = true;
            statBC.x = 200;
            statBC.y = 280;
            addChild(statBC);
        }

        private function setHeartRate(heartRate:uint):String
        {
            this.heartRate = heartRate;
            return heartRate + ' BPM';
        }

        private function setOxygenLevel(oxygenLevel:uint):String
        {
			if (oxygenLevel < 90) {
				oxygenLevel = 90;
			}
			
			if (oxygenLevel > 100) {
				oxygenLevel = 100;
			}
			
            this.oxygenLevel = oxygenLevel;
            return oxygenLevel + '%';
        }

        private function setBloodPressure(bloodPressureSys:uint, bloodPressureDys:uint):String
        {
			if (bloodPressureSys < 100) {
				bloodPressureSys = 100;
			}
			
			if (bloodPressureSys > 155) {
				bloodPressureSys = 155;
			}
			
			if (bloodPressureDys < 60) {
				bloodPressureDys = 60;
			}
			
			if (bloodPressureDys > 100) {
				bloodPressureDys = 100;
			}
			
            this.bloodPressureSys = bloodPressureSys;
            this.bloodPressureDys = bloodPressureDys;
            return bloodPressureSys + ' / ' + bloodPressureDys;
        }

        private function setBloodCount(bloodCount:uint):String
        {
            this.bloodCount = bloodCount;
            return bloodCount + ' ml';
        }
    }
}