package gui.inventory.phonemenu
{
    import global.Global;

    /**
     * @author @shaun
     */
    public class ActParams
    {
        /* params.act 				- M
         * params.deviceOwner 		- M
         * params.rfidNo        	 - M
         * params.leaderboardRank 	- M
         * params.date 				- M
         * params.time 				- M
         * params.apps 				- O - Defaults to None
         * params.condition 		- O - Defaults to fine
         * params.contacts 			- O - Defaults to None
         **/
        private const RILEY_RFID:String = "M3-RM-52417322"
        private const RILEY_OWNER:String = "Riley P. Marshall";
        private const PREMIUM_PLATINUM:String = "AID-Plus Gold";
        private const RILEY_PREMIUM_EXPIRY_DATE:String = "10/06/2037";
        /***********************************************************************/
		/** LEVEL 1 - ACT 1
         /***********************************************************************/
        private const LEVEL1_ACT_1_ACT:String = "Riley's Apartment";
        private const LEVEL1_ACT_1_LEADERBOARD_RANK:String = "8";
        private const LEVEL1_ACT_1_DATE:Date = new Date(2036, 09, 18, 19, 32, 0);
        //private const LEVEL1_ACT_1_DATE:Date = new Date(2036, 09, 18, 19, 59, 50);
        private const LEVEL1_ACT_1_DATE_DEADLINE:Date = new Date(2036, 09, 18, 20, 0, 0);
        /***********************************************************************/
        /**  LEVEL 1 - ACT 3 - Slums Street
         /***********************************************************************/
        private const LEVEL1_ACT_3_ACT:String = "The Slums - Baker Street";
        private const LEVEL1_ACT_3_LEADERBOARD_RANK:String = "9";
        private const LEVEL1_ACT_3_DATE:Date = new Date(2036, 09, 18, 20, 15, 0);
        //private const LEVEL1_ACT_3_DATE:Date = new Date(2036, 09, 18, 20, 24, 40);
        private const LEVEL1_ACT_3_DATE_DEADLINE:Date = new Date(2036, 09, 18, 20, 25, 0);
        /***********************************************************************/
        /** LEVEL 1 - ACT 4 - Slums Back Alley
         /***********************************************************************/
        private const LEVEL1_ACT_4_ACT:String = "The Slums - Back Alley";
        private const LEVEL1_ACT_4_LEADERBOARD_RANK:String = "9";
        private const LEVEL1_ACT_4_DATE:Date = new Date(2036, 09, 18, 20, 30, 0);
        //private const LEVEL1_ACT_4_DATE:Date = new Date(2036, 09, 18, 20, 44, 30);
        private const LEVEL1_ACT_4_DATE_DEADLINE:Date = new Date(2036, 09, 18, 20, 45, 0);
        /***********************************************************************/
        /** LEVEL 5 - ACT 5 - Compound
         /***********************************************************************/
        private const LEVEL1_ACT_5_ACT:String = "The Slums - Compound";
        private const LEVEL1_ACT_5_LEADERBOARD_RANK:String = "8";
        private const LEVEL1_ACT_5_DATE:Date = new Date(2036, 09, 18, 20, 30, 0);
        //private const LEVEL1_ACT_5_DATE:Date = new Date(2036, 09, 18, 20, 44, 30);
        private const LEVEL1_ACT_5_DATE_DEADLINE:Date = new Date(2036, 09, 18, 20, 45, 0);
        /***********************************************************************/
		
        public function getLevelOneActOneParams():Object
        {
            var params:Object = new Object();
            params.act = LEVEL1_ACT_1_ACT;
            params.deviceOwner = RILEY_OWNER;
            params.rfidNo = RILEY_RFID;
            params.leaderboardRank = LEVEL1_ACT_1_LEADERBOARD_RANK;
            params.date = LEVEL1_ACT_1_DATE;
            params.deadlineDate = LEVEL1_ACT_1_DATE_DEADLINE;
            params.condition = "fine";
            params.rfidSignalStrength = 99;
            params.heartRate = 45;
            params.oxygenLevel = 96;
            params.bloodCount = Global.getRandomNumber(5000000, 6000000);
            params.bloodPressureSys = 105;
            params.bloodPressureDys = 67;
            params.currentMembership = this.PREMIUM_PLATINUM;
            params.membershipExp = RILEY_PREMIUM_EXPIRY_DATE;
            return params;
        }

        public function getLevelOneActThreeParams():Object
        {
            var params:Object = new Object();
            params.act = LEVEL1_ACT_3_ACT;
            params.deviceOwner = RILEY_OWNER;
            params.rfidNo = RILEY_RFID;
            params.leaderboardRank = LEVEL1_ACT_3_LEADERBOARD_RANK;
            params.date = LEVEL1_ACT_3_DATE;
            params.deadlineDate = LEVEL1_ACT_3_DATE_DEADLINE;
            params.condition = "fine";
            params.rfidSignalStrength = 88;
            params.heartRate = 92;
            params.oxygenLevel = 98;
            params.bloodCount = Global.getRandomNumber(5000000, 6000000);
            params.bloodPressureSys = 122;
            params.bloodPressureDys = 87;
            params.currentMembership = this.PREMIUM_PLATINUM;
            params.membershipExp = RILEY_PREMIUM_EXPIRY_DATE;
            return params;
        }

        public function getLevelOneActFourParams():Object
        {
            var params:Object = new Object();
            params.act = LEVEL1_ACT_4_ACT;
            params.deviceOwner = RILEY_OWNER;
            params.rfidNo = RILEY_RFID;
            params.leaderboardRank = LEVEL1_ACT_4_LEADERBOARD_RANK;
            params.date = LEVEL1_ACT_4_DATE;
            params.deadlineDate = LEVEL1_ACT_4_DATE_DEADLINE;
            params.condition = "fine";
            params.rfidSignalStrength = 89;
            params.heartRate = 101;
            params.oxygenLevel = 98;
            params.bloodCount = Global.getRandomNumber(5000000, 6000000);
            params.bloodPressureSys = 132;
            params.bloodPressureDys = 90;
            params.currentMembership = this.PREMIUM_PLATINUM;
            params.membershipExp = RILEY_PREMIUM_EXPIRY_DATE;
            return params;
        }

        public function getLevelOneActFiveParams():Object
        {
            var params:Object = new Object();
            params.act = LEVEL1_ACT_5_ACT;
            params.deviceOwner = RILEY_OWNER;
            params.rfidNo = RILEY_RFID;
            params.leaderboardRank = LEVEL1_ACT_5_LEADERBOARD_RANK;
            params.date = LEVEL1_ACT_5_DATE;
            params.condition = "worried";
            params.deadlineDate = LEVEL1_ACT_5_DATE_DEADLINE;
            params.rfidSignalStrength = 98;
            params.heartRate = 125;
            params.oxygenLevel = 99;
            params.bloodCount = Global.getRandomNumber(5000000, 6000000);
            params.bloodPressureSys = 145;
            params.bloodPressureDys = 93;
            params.currentMembership = this.PREMIUM_PLATINUM;
            params.membershipExp = RILEY_PREMIUM_EXPIRY_DATE;
            return params;
        }
    }
}