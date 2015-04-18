package gui.inventory
{
    /**
     * ...
     * @author @shaun
     */
    public class Validator
    {
        /**
         * @desc This will validate the health menu params
         * @param    params
         *
         * M - Mandatory
         * O - Optional
         *
         * this.rfidSignalStrength    - M - 89
         * this.heartRate            - M - 65
         * this.oxygenLevel        - M - 99
         * this.bloodPressureSys    - M - 120
         * this.bloodPressureDys    - M - 80
         * this.currentMembership    - M - "Premium Platinum" | "Premium Gold" | "Standard Member"
         *
         */
        public static function checkHealthMenuParams(p:Object):void
        {
            if (!checkifNullOrUndefined(p.rfidSignalStrength)) {
                throw new Error("Missing param rfidSignalStrength");
            }
            if (!checkifNullOrUndefined(p.heartRate)) {
                throw new Error("Missing param heartRate");
            }
            if (!checkifNullOrUndefined(p.oxygenLevel)) {
                throw new Error("Missing param oxygenLevel");
            }
            if (!checkifNullOrUndefined(p.bloodCount)) {
                throw new Error("Missing param bloodCount");
            }
            if (!checkifNullOrUndefined(p.bloodPressureSys)) {
                throw new Error("Missing param bloodPressureSys");
            }
            if (!checkifNullOrUndefined(p.bloodPressureDys)) {
                throw new Error("Missing param bloodPressureDys");
            }
            if (!checkifNullOrUndefined(p.currentMembership)) {
                throw new Error("Missing param currentMembership");
            }
            if (!checkifNullOrUndefined(p.membershipExp)) {
                throw new Error("Missing param membershipExp");
            }
        }

        public static function checkifNullOrUndefined(val:*):Boolean
        {
            if (val !== undefined) {
                if (val !== null) {
                    return true;
                }
            }
            throw new Error(val + " is Null or Undefined");
        }

        /**
         * @desc This will validate the following params
         * @param    params
         *
         * M - Mandatory
         * O - Optional
         *
         * params.act                - M
         * params.deviceOwner        - M
         * -- params.currentRank     - M ( DEPRECATED )
         * params.rfidNo             - M
         * params.leaderboardRank    - M
         * params.date               - M
         * params.deadlineDate       - M
         * params.apps               - O - Defaults to None
         * params.condition          - O - Defaults to fine
         * params.contacts           - O - Defaults to None
         *
         */
        public function checkMandatoryPhoneMenuParams(params:Object):Boolean
        {
            if (!checkifNullOrUndefined(params.act)) {
                throw new Error("Missing param");
            }
            if (!checkifNullOrUndefined(params.deviceOwner)) {
                throw new Error("Missing param");
            }
            if (!checkifNullOrUndefined(params.rfidNo)) {
                throw new Error("Missing param");
            }
            if (!checkifNullOrUndefined(params.leaderboardRank)) {
                throw new Error("Missing param");
            }
            if (!checkifNullOrUndefined(params.date)) {
                throw new Error("Missing param");
            }
            if (!checkifNullOrUndefined(params.deadlineDate)) {
                throw new Error("Missing param");
            }
            trace("passed validation for checkMandatoryPhoneMenuParams()");
            return true;
        }
    }
}