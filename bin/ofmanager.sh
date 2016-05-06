#!/bin/bash
#
# @brief   OpenOffice Server Management
# @version ver.1.0
# @date    Mon Aug 24 17:03:32 2015
# @company Frobas IT Department, www.frobas.com 2015
# @author  Vladimir Roncevic <vladimir.roncevic@frobas.com>
#  
UTIL_ROOT=/root/scripts
UTIL_VERSION=ver.1.0
UTIL=$UTIL_ROOT/sh-util-srv/$UTIL_VERSION
UTIL_LOG=$UTIL/log

. $UTIL/bin/checkroot.sh
. $UTIL/bin/checktool.sh
. $UTIL/bin/checkop.sh
. $UTIL/bin/logging.sh
. $UTIL/bin/usage.sh
. $UTIL/bin/devel.sh

TOOL_NAME=ofmanager
TOOL_VERSION=ver.1.0
TOOL_HOME=$UTIL_ROOT/$TOOL_NAME/$TOOL_VERSION
TOOL_CFG=$TOOL_HOME/conf/$TOOL_NAME.cfg
TOOL_LOG=$TOOL_HOME/log

declare -A OFMANAGER_USAGE=(
	[TOOL_NAME]="__$TOOL_NAME"
	[ARG1]="[OPERATION] start | stop | restart | status | version"
	[EX-PRE]="# Start OpenOffice service"
	[EX]="__$TOOL_NAME start"	
)

declare -A LOG=(
	[TOOL]="$TOOL_NAME"
	[FLAG]="info"
	[PATH]="$TOOL_LOG"
	[MSG]=""
)

TOOL_DEBUG="false"

SYSTEMCTL="/usr/bin/systemctl"
OF_OP_LIST=( start stop restart status version )

#
# @brief  Run operation on OpenOffice service
# @param  Value required operation to be done
# @retval Success return 0, else return 1
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# OPERATION="start"
# __ofoperation "$OPERATION"
# STATUS=$?
#
# if [ "$STATUS" -eq "$SUCCESS" ]; then
#	# true
# else
#	# false
# fi
#
function __ofoperation() {
    OPERATION=$1
    if [ -n "$OPERATION" ]; then
        if [ "$OPERATION" == "restart" ]; then
            eval "$SYSTEMCTL stop openoffice.service"
			sleep 2
            eval "$SYSTEMCTL start openoffice.service"
        else
			if [ "$TOOL_DEBUG" == "true" ]; then
				printf "%s\n" "CMD: $SYSTEMCTL $OPERATION openoffice.service"
			fi
            eval "$SYSTEMCTL $OPERATION openoffice.service"
        fi
        return $SUCCESS
    fi
	return $NOT_SUCCESS
}

#
# @brief  Main function  
# @param  Value required operation to be done
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __smbmanager "$OPERATION"
#
function __ofmanager() {
    OPERATION=$1
    if [ -n "$OPERATION" ]; then
		if [ "$TOOL_DEBUG" == "true" ]; then
			printf "%s\n" "[OpenOffice Server Manager]"
		fi
        __checkop "$OPERATION" "${OF_OP_LIST[*]}"
        STATUS=$?
        if [ "$STATUS" -eq "$SUCCESS" ]; then
            __ofoperation "$OPERATION"
			if [ "$TOOL_DEBUG" == "true" ]; then
				printf "%s\n\n" "[Done]"
			fi
		    exit 0
        fi
		__usage $OFMANAGER_USAGE
		exit 129
    fi
	__usage $OFMANAGER_USAGE
    exit 128
}

#
# @brief Main entry point
# @param required value operation to be done
# @exitval Script tool ofmanger exit with integer value
#			0   - success operation 
# 			127 - run as root user
#			128 - missing argument
#			129 - wrong argument (operation)
#
printf "\n%s\n%s\n\n" "$TOOL_NAME $TOOL_VERSION" "`date`"
__checkroot
STATUS=$?
if [ "$STATUS" -eq "$SUCCESS" ]; then
	__ofmanager "$1"
fi

exit 127

