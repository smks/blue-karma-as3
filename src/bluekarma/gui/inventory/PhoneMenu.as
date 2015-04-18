package gui.inventory
{
    import flash.globalization.StringTools;
	import gui.phone.contacts.Contact;
	import gui.phone.contacts.ContactMenu;

    import gui.inventory.abstract.AbstractPhoneMenu;

    /**
     * ...
     * @author Shaun Stone
     */
    public class PhoneMenu extends AbstractPhoneMenu
    {
        public static const FINE:String = "fine";
        public static const UNEASY:String = "uneasy";
        public static const TERRIFIED:String = "terrified";

        public function PhoneMenu(_params:Object)
        {
            super(_params);
        }

        // add reminders to phone menu
        public function addReminder(id:String, reminder:String, priority:String = FINE):void
        {
            reminderBox.addReminder(id, reminder, priority);
        }

        public function addApp(name:String):void
        {
            // @todo
        }

        public function addContact(id:String, name:String, status:Boolean):void
        {
			contactMenu.addContact(id, name, status);
        }

        public function setCondition(state:String):void
        {
            switch (state) {
                case FINE :
                    condition.color = 0x91D078;
                    break;
                case UNEASY :
                    condition.color = 0xECCD67;
                    break;
                case TERRIFIED :
                    condition.color = 0xEC4343;
                    break;
            }
            if (healthMenu !== null) {
                healthMenu.setState(state);
            }
            condition.text = state.toUpperCase();
        }

        /**
         * @return
         */
        public function hasReminders():Boolean
        {
            return (reminderBox.countReminders() > 0) ? true : false;
        }

        public function getLatestReminder():String
        {
            return reminderBox.getLatestReminder();
        }

        public function removeLatestReminder():void
        {
            reminderBox.removeLatest();
        }
		
		public function getContactMenu():ContactMenu 
		{
			return contactMenu;
		}
    }
}