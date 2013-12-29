Pushover Notifications for Check_MK
------------------------------------

This is my script for sending Pushover notifications (http://pushover.net) from Check_MK.

Add notify_by_pushover.sh to your check_mk/notifications directory and make sure it's executable.
/omd/sites/site-name/local/share/check_mk/notifications if you're running OMD (http://omdistro.org)

Follow the steps in the Check_MK docs to add the new notification script. ([Check_MK docs](http://mathias-kettner.de/checkmk_flexible_notifications.html#H1:Configuring flexible configurations in WATO))

Pushover needs a User & Application API key:
- Save the user's key in the Pager address field. 
- Set the application key as the first plugin argument in the notifications config.

Note: This is a functional first-attempt. I'll refine this as I go.

Better setup instructions coming soon...
