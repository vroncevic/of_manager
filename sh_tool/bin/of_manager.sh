#!/bin/bash
#
# @brief   Open Office Manager
# @version ver.2.0
# @date    Sun 28 Nov 2021 08:24:52 AM CET
# @company None, free software to use 2021
# @author  Vladimir Roncevic <elektron.ronca@gmail.com>
#
UTIL_ROOT=/root/scripts
UTIL_VERSION=ver.1.0
UTIL=${UTIL_ROOT}/sh_util/${UTIL_VERSION}
UTIL_LOG=${UTIL}/log

.    ${UTIL}/bin/devel.sh
.    ${UTIL}/bin/usage.sh
.    ${UTIL}/bin/check_root.sh
.    ${UTIL}/bin/check_tool.sh
.    ${UTIL}/bin/check_op.sh
.    ${UTIL}/bin/logging.sh
.    ${UTIL}/bin/load_conf.sh
.    ${UTIL}/bin/load_util_conf.sh
.    ${UTIL}/bin/progress_bar.sh

OF_MANAGER_TOOL=of_manager
OF_MANAGER_VERSION=ver.2.0
OF_MANAGER_HOME=${UTIL_ROOT}/${OF_MANAGER_TOOL}/${OF_MANAGER_VERSION}
OF_MANAGER_CFG=${OF_MANAGER_HOME}/conf/${OF_MANAGER_TOOL}.cfg
OF_MANAGER_UTIL_CFG=${OF_MANAGER_HOME}/conf/${OF_MANAGER_TOOL}_util.cfg
OF_MANAGER_LOGO=${OF_MANAGER_HOME}/conf/${OF_MANAGER_TOOL}.logo
OF_MANAGER_LOG=${OF_MANAGER_HOME}/log

tabs 4
CONSOLE_WIDTH=$(stty size | awk '{print $2}')

.    ${OF_MANAGER_HOME}/bin/center.sh
.    ${OF_MANAGER_HOME}/bin/display_logo.sh
.    ${OF_MANAGER_HOME}/bin/of_operation.sh

declare -A OF_MANAGER_USAGE=(
    [USAGE_TOOL]="${OF_MANAGER_TOOL}"
    [USAGE_ARG1]="[OPERATION] start | stop | restart | status | version"
    [USAGE_EX_PRE]="# Start OpenOffice service"
    [USAGE_EX]="${OF_MANAGER_TOOL} start"
)

declare -A OF_MANAGER_LOGGING=(
    [LOG_TOOL]="${OF_MANAGER_TOOL}"
    [LOG_FLAG]="info"
    [LOG_PATH]="${OF_MANAGER_LOG}"
    [LOG_MSGE]="None"
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
# @retval Function __of_manager exit with integer value
#            0   - tool finished with success operation
#            128 - missing argument(s) from cli
#            129 - failed to load tool script configuration from files
#            130 - missing external tool systemctl
#            131 - wrong argument
#            132 - falied to finish operation
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __of_manager "$OP"
#
function __of_manager {
    local OP=$1
    display_logo
    if [ -n "${OP}" ]; then
        local FUNC=${FUNCNAME[0]} MSG="None"
        local STATUS_CONF STATUS_CONF_UTIL STATUS
        MSG="Loading basic and util configuration!"
        info_debug_message "$MSG" "$FUNC" "$OF_MANAGER_TOOL"
        progress_bar PB_STRUCTURE
        declare -A config_of_manager=()
        load_conf "$OF_MANAGER_CFG" config_of_manager
        STATUS_CONF=$?
        declare -A config_of_manager_util=()
        load_util_conf "$OF_MANAGER_UTIL_CFG" config_of_manager_util
        STATUS_CONF_UTIL=$?
        declare -A STATUS_STRUCTURE=([1]=$STATUS_CONF [2]=$STATUS_CONF_UTIL)
        check_status STATUS_STRUCTURE
        STATUS=$?
        if [ $STATUS -eq $NOT_SUCCESS ]; then
            MSG="Force exit!"
            info_debug_message_end "$MSG" "$FUNC" "$OF_MANAGER_TOOL"
            exit 129
        fi
        TOOL_DBG=${config_of_manager[DEBUGGING]}
        TOOL_LOG=${config_of_manager[LOGGING]}
        TOOL_NOTIFY=${config_of_manager[EMAILING]}
        local SYSCTL=${config_of_manager_util[SYSTEMCTL]}
        check_tool "${SYSCTL}"
        STATUS=$?
        if [ $STATUS -eq $NOT_SUCCESS ]; then
            MSG="Force exit!"
            info_debug_message_end "$MSG" "$FUNC" "$OF_MANAGER_TOOL"
            exit 130
        fi
        local OPERATIONS=${config_of_manager_util[OFMANAGER_OPERATIONS]}
        IFS=' ' read -ra OPS <<< "${OPERATIONS}"
        check_op "$OP" "${OPS[*]}"
        STATUS=$?
        if [ $STATUS -eq $SUCCESS ]; then
            __of_operation "${OP}"
            STATUS=$?
            if [ $STATUS -eq $NOT_SUCCESS ]; then
                MSG="Failed to finish ${OP}"
                info_debug_message "$MSG" "$FUNC" "$OF_MANAGER_TOOL"
                exit 132
            fi
            info_debug_message_end "Done" "$FUNC" "$OF_MANAGER_TOOL"
            exit 0
        fi
        usage OF_MANAGER_USAGE
        exit 131
    fi
    usage OF_MANAGER_USAGE
    exit 128
}

#
# @brief Main entry point
# @param required value operation to be done
# @exitval Script tool ofmanger exit with integer value
#            0   - tool finished with success operation
#            127 - un tool script as root user from cli
#            128 - missing argument(s) from cli
#            129 - failed to load tool script configuration from files
#            130 - missing external tool systemctl
#            131 - wrong argument
#            132 - falied to finish operation
#
printf "\n%s\n%s\n\n" "${OF_MANAGER_TOOL} ${OF_MANAGER_VERSION}" "`date`"
check_root
STATUS=$?
if [ $STATUS -eq $SUCCESS ]; then
    __of_manager $1
fi

exit 127
