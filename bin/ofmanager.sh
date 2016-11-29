#!/bin/bash
#
# @brief   OpenOffice Server Management (wrapper)
# @version ver.1.0
# @date    Mon Aug 24 17:03:32 2015
# @company Frobas IT Department, www.frobas.com 2015
# @author  Vladimir Roncevic <vladimir.roncevic@frobas.com>
#  
UTIL_ROOT=/root/scripts
UTIL_VERSION=ver.1.0
UTIL=$UTIL_ROOT/sh-util-srv/$UTIL_VERSION
UTIL_LOG=$UTIL/log

. $UTIL/bin/devel.sh
. $UTIL/bin/usage.sh
. $UTIL/bin/checkroot.sh
. $UTIL/bin/checktool.sh
. $UTIL/bin/checkop.sh
. $UTIL/bin/logging.sh
. $UTIL/bin/sendmail.sh
. $UTIL/bin/loadconf.sh
. $UTIL/bin/loadutilconf.sh
. $UTIL/bin/progressbar.sh

OFMANAGER_NAME=ofmanager
OFMANAGER_VERSION=ver.1.0
OFMANAGER_HOME=$UTIL_ROOT/$OFMANAGER_NAME/$OFMANAGER_VERSION
OFMANAGER_CFG=$OFMANAGER_HOME/conf/$OFMANAGER_NAME.cfg
OFMANAGER_UTIL_CFG=$OFMANAGER_HOME/conf/${OFMANAGER_TOOL}_util.cfg
OFMANAGER_LOG=$OFMANAGER_HOME/log

declare -A OFMANAGER_USAGE=(
	[TOOL_NAME]="__$OFMANAGER_NAME"
	[ARG1]="[OPERATION] start | stop | restart | status | version"
	[EX-PRE]="# Start OpenOffice service"
	[EX]="__$TOOL_NAME start"	
)

declare -A OFMANAGER_LOG=(
	[TOOL]="$TOOL_NAME"
	[FLAG]="info"
	[PATH]="$TOOL_LOG"
	[MSG]=""
)

declare -A PB_STRUCTURE=(
	[BAR_WIDTH]=50
	[MAX_PERCENT]=100
	[SLEEP]=0.01
)

TOOL_DEBUG="false"

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
# if [ $STATUS -eq $SUCCESS ]; then
#	# true
# else
#	# false
# fi
#
function __ofoperation() {
    local OPERATION=$1
    if [ -n "$OPERATION" ]; then
        if [ "$OPERATION" == "restart" ]; then
            eval "${configofmanagerutil[SYSTEMCTL]} stop openoffice.service"
			sleep 2
            eval "${configofmanagerutil[SYSTEMCTL]} start openoffice.service"
        else
			if [ "$TOOL_DEBUG" == "true" ]; then
				printf "%s\n" "CMD: ${configofmanagerutil[SYSTEMCTL]} $OPERATION openoffice.service"
			fi
            eval "${configofmanagerutil[SYSTEMCTL]} $OPERATION openoffice.service"
        fi
        return $SUCCESS
    fi
	return $NOT_SUCCESS
}

#
# @brief  Main function  
# @param  Value required operation to be done
# @retval Function __ofmanger exit with integer value
#			0   - tool finished with success operation 
#			128 - missing argument(s) from cli 
#			129 - failed to load tool script configuration from file 
#			130 - failed to load tool script utilities configuration from file
#			131 - missing external tool systemctl
#			132 - falied to finish operation
#			133 - wrong argument
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __smbmanager "$OPERATION"
#
function __ofmanager() {
    local OPERATION=$1
    if [ -n "$OPERATION" ]; then
		local FUNC=${FUNCNAME[0]}
		local MSG="Loading basic and util configuration"
		printf "$SEND" "$OFMANAGER_TOOL" "$MSG"
		__progressbar PB_STRUCTURE
		printf "%s\n\n" ""
		declare -A configofmanager=()
		__loadconf $OFMANAGER_CFG configofmanager
		local STATUS=$?
		if [ $STATUS -eq $NOT_SUCCESS ]; then
			MSG="Failed to load tool script configuration"
			if [ "$TOOL_DBG" == "true" ]; then
				printf "$DSTA" "$OFMANAGER_TOOL" "$FUNC" "$MSG"
			else
				printf "$SEND" "$OFMANAGER_TOOL" "$MSG"
			fi
			exit 129
		fi
		declare -A configofmanagerutil=()
		__loadutilconf $OFMANAGER_UTIL_CFG configofmanagerutil
		STATUS=$?
		if [ $STATUS -eq $NOT_SUCCESS ]; then
			MSG="Failed to load tool script utilities configuration"
			if [ "$TOOL_DBG" == "true" ]; then
				printf "$DSTA" "$OFMANAGER_TOOL" "$FUNC" "$MSG"
			else
				printf "$SEND" "$OFMANAGER_TOOL" "$MSG"
			fi
			exit 130
		fi
		if [ "$TOOL_DEBUG" == "true" ]; then
			printf "%s\n" "[OpenOffice Server Manager]"
		fi
		__checktool "${configofmanagerutil[SYSTEMCTL]}"
		STATUS=$?
		if [ $STATUS -eq $NOT_SUCCESS ]; then
			MSG="Missing external tool ${configofmanagerutil[SYSTEMCTL]}"
			if [ "${configofmanager[LOGGING]}" == "true" ]; then
				OFMANAGER_LOGGING[LOG_MSGE]="$MSG"
				OFMANAGER_LOGGING[LOG_FLAG]="error"
				__logging OFMANAGER_LOGGING
			fi
			if [ "${configofmanager[EMAILING]}" == "true" ]; then
				__sendmail "$MSG" "${configofmanager[ADMIN_EMAIL]}"
			fi
			exit 131
		fi
		OF_OP_LIST=( start stop restart status version )
        __checkop "$OPERATION" "${OF_OP_LIST[*]}"
        STATUS=$?
        if [ $STATUS -eq $SUCCESS ]; then
            __ofoperation "$OPERATION"
			STATUS=$?
			if [ $STATUS -eq $NOT_SUCCESS ]; then
				MSG="Failed to finish $OPERATION"
				if [ "${configofmanager[LOGGING]}" == "true" ]; then
					OFMANAGER_LOGGING[LOG_MSGE]="$MSG"
					OFMANAGER_LOGGING[LOG_FLAG]="error"
					__logging OFMANAGER_LOGGING
				fi
				if [ "$TOOL_DBG" == "true" ]; then
					printf "$DSTA" "$OFMANAGER_TOOL" "$FUNC" "$MSG"
				else
					printf "$SEND" "$OFMANAGER_TOOL" "$MSG"
				fi
				exit 132
			fi
			if [ "$TOOL_DBG" == "true" ]; then
				printf "$DSTA" "$OFMANAGER_TOOL" "$FUNC" "Done"
			else
				printf "$SEND" "$OFMANAGER_TOOL" "Done"
			fi
		    exit 0
        fi
		__usage OFMANAGER_USAGE
		exit 133
    fi
	__usage OFMANAGER_USAGE
    exit 128
}

#
# @brief Main entry point
# @param required value operation to be done
# @exitval Script tool ofmanger exit with integer value
#			0   - tool finished with success operation 
# 			127 - un tool script as root user from cli
#			128 - missing argument(s) from cli 
#			129 - failed to load tool script configuration from file 
#			130 - failed to load tool script utilities configuration from file
#			131 - missing external tool systemctl
#			132 - falied to finish operation
#			133 - wrong argument
#
printf "\n%s\n%s\n\n" "$OFMANAGER_NAME $OFMANAGER_VERSION" "`date`"
__checkroot
STATUS=$?
if [ $STATUS -eq $SUCCESS ]; then
	__ofmanager $1
fi

exit 127

