#!/bin/bash
# Notify by Pushover

#	Notify by Pushover for Check_MK
#	adapted by John McCulloch
#
#	originally by Jedda Wignall
#	http://jedda.me

#	v1.3.0 - 29 Dec 2013
#	Initial Check_MK adaptation.
#	Removing explicit sound settings to favour user preferences in client app.

#	v1.2 - 18 Dec 2012
#	Added parsing of title for specific warning, critical, and OK sounds.

#	v1.1 - 02 Dec 2012
#	Added notification sounds.

#	v1.0 - 21 Aug 2012
#	Initial release.

#	This script sends a Pushover (http://pushover.net/) notification to your iOS & Android devices from Check_MK.

#	IMPORTANT
#	You will need to create a Pushover 'Application' for this script in your account and use the provided API key
#	as argument 1 in Check_MK's flexible notifications config. You can register an app once logged into Pushover at the following link:
#	https://pushover.net/apps/build
#
#	This script is set up to look for the Pushover user key in the Pager Address/Address2 field.

# 	You also need to provide your Pushover application key as the first argument in the Check_MK notification config.

# Get data from Check_MK environment variables.
# Reference: http://mathias-kettner.de/checkmk_flexible_notifications.html#H1:Real World Notification Scripts
pushoverUserKey=$NOTIFY_CONTACTPAGER
appToken=$NOTIFY_PARAMETER_1

hostAddress=$NOTIFY_HOSTADDRESS
hostAlias=$NOTIFY_HOSTALIAS
hostState=$NOTIFY_HOSTSTATE
hostOutput=$NOTIFY_HOSTOUTPUT

serviceDesc=$NOTIFY_SERVICEDESC
serviceState=$NOTIFY_SERVICESTATE
serviceOutput=$NOTIFY_SERVICEOUTPUT

# You can change message priorities for each notification type.
# See https://pushover.net/api#priority for details.
case "$serviceState" in
    CRITICAL)   priority=1;;
    WARNING)    priority=0;;
    OK)         priority=0;;
    *)          priority=0;;
esac

# Check if the service state is set. If not then don't show service details in msg.
if [[ -z "$NOTIFY_SERVICESTATE" ]]
then
	# Service details not set.
	title="$hostAlias $hostState"
	message=$hostAlias' is '$hostState$'\n'$hostOutput
else
	title="$hostAlias $hostState - $serviceDesc $serviceState"
	message=$'Service:\n'$serviceDesc$'\n'$serviceState$'\n'$serviceOutput$'\nHost:\n'$hostAlias' is '$hostState$'\n'$hostOutput
fi

curl -F "token=$appToken" \
-F "user=$pushoverUserKey" \
-F "title=$title" \
-F "message=$message" \
-F "priority=$priority" \
https://api.pushover.net/1/messages

exit 0
