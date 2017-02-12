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
UTIL=${UTIL_ROOT}/sh_util/${UTIL_VERSION}
UTIL_LOG=${UTIL}/log

.	${UTIL}/bin/devel.sh
.	${UTIL}/bin/usage.sh
.	${UTIL}/bin/check_root.sh
.	${UTIL}/bin/check_tool.sh
.	${UTIL}/bin/check_op.sh
.	${UTIL}/bin/logging.sh
.	${UTIL}/bin/load_conf.sh
.	${UTIL}/bin/load_util_conf.sh
.	${UTIL}/bin/progress_bar.sh

OFMANAGER_TOOL=ofmanager
OFMANAGER_VERSION=ver.1.0
OFMANAGER_HOME=${UTIL_ROOT}/${OFMANAGER_TOOL}/${OFMANAGER_VERSION}
OFMANAGER_CFG=${OFMANAGER_HOME}/conf/${OFMANAGER_TOOL}.cfg
OFMANAGER_UTIL_CFG=${OFMANAGER_HOME}/conf/${OFMANAGER_TOOL}_util.cfg
OFMANAGER_LOG=${OFMANAGER_HOME}/log

.	${OFMANAGER_HOME}/bin/of_operation.sh

declare -A OFMANAGER_USAGE=(
	[TOOL_NAME]="${OFMANAGER_TOOL}"
	[ARG1]="[OPERATION] start | stop | restart | status | version"
	[EX-PRE]="# Start OpenOffice service"
	[EX]="${OFMANAGER_TOOL} start"
)

declare -A OFMANAGER_LOGGING=(
	[TOOL]="${OFMANAGER_TOOL}"
	[FLAG]="info"
	[PATH]="${OFMANAGER_LOG}"
	[MSG]="None"
)

declare -A PB_STRUCTURE=(
	[BW]=50
	[MP]=100
	[SLEEP]=0.01
)

TOOL_DBG="false"
TOOL_LOG="false"
TOOL_NOTIFY="false"

#
# @brief  Main function
# @param  Value required operation to be done
# @retval Function __ofmanger exit with integer value
#			0   - tool finished with success operation
#			128 - missing argument(s) from cli
#			129 - failed to load tool script configuration from files
#			130 - missing external tool systemctl
#			131 - wrong argument
#			132 - falied to finish operation
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __smbmanager "$OP"
#
function __ofmanager() {
	local OP=$1
	if [ -n "${OP}" ]; then
		local FUNC=${FUNCNAME[0]} MSG="None" STATUS_CONF STATUS_CONF_UTIL STATUS
		MSG="Loading basic and util configuration!"
		__info_debug_message "$MSG" "$FUNC" "$OFMANAGER_TOOL"
		__progress_bar PB_STRUCTURE
		declare -A config_ofmanager=()
		__load_conf "$OFMANAGER_CFG" config_ofmanager
		STATUS_CONF=$?
		declare -A config_ofmanager_util=()
		__load_util_conf "$OFMANAGER_UTIL_CFG" config_ofmanager_util
		STATUS_CONF_UTIL=$?
		declare -A STATUS_STRUCTURE=([1]=$STATUS_CONF [2]=$STATUS_CONF_UTIL)
		__check_status STATUS_STRUCTURE
		STATUS=$?
		if [ $STATUS -eq $NOT_SUCCESS ]; then
			MSG="Force exit!"
			__info_debug_message_end "$MSG" "$FUNC" "$OFMANAGER_TOOL"
			exit 129
		fi
		TOOL_DBG=${config_ofmanager[DEBUGGING]}
		TOOL_LOG=${config_ofmanager[LOGGING]}
		TOOL_NOTIFY=${config_ofmanager[EMAILING]}
		MSG=""
		__info_debug_message "$MSG" "$FUNC" "$OFMANAGER_TOOL"
		local SYSCTL=${config_ofmanager_util[SYSTEMCTL]}
		__check_tool "${SYSCTL}"
		STATUS=$?
		if [ $STATUS -eq $NOT_SUCCESS ]; then
			MSG="Force exit!"
			__info_debug_message_end "$MSG" "$FUNC" "$OFMANAGER_TOOL"
			exit 130
		fi
		local OPERATIONS=${config_ofmanager_util[OFMANAGER_OPERATIONS]}
		IFS=' ' read -ra OPS <<< "${OPERATIONS}"
		__check_op "$OP" "${OPS[*]}"
		STATUS=$?
		if [ $STATUS -eq $SUCCESS ]; then
			__of_operation "${OP}"
			STATUS=$?
			if [ $STATUS -eq $NOT_SUCCESS ]; then
				MSG="Failed to finish ${OP}"
				__info_debug_message "$MSG" "$FUNC" "$OFMANAGER_TOOL"
				exit 132
			fi
			__info_debug_message_end "Done" "$FUNC" "$OFMANAGER_TOOL"
			exit 0
		fi
		__usage OFMANAGER_USAGE
		exit 131
	fi
	__usage OFMANAGER_USAGE
	exit 128
}

#
# @brief Main entry point
# @param required value operation to be done
# @exitval Script tool ofmanger exit with integer value
#			0   - tool finished with success operation
#			127 - un tool script as root user from cli
#			128 - missing argument(s) from cli
#			129 - failed to load tool script configuration from files
#			130 - missing external tool systemctl
#			131 - wrong argument
#			132 - falied to finish operation
#
printf "\n%s\n%s\n\n" "${OFMANAGER_NAME} ${OFMANAGER_VERSION}" "`date`"
__check_root
STATUS=$?
if [ $STATUS -eq $SUCCESS ]; then
	__ofmanager $1
fi

exit 127

