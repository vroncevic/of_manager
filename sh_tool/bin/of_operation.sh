#!/bin/bash
#
# @brief   Run operation on OpenOffice service
# @version ver.1.0
# @date    Mon Aug 24 17:03:32 2015
# @company Frobas IT Department, www.frobas.com 2015
# @author  Vladimir Roncevic <vladimir.roncevic@frobas.com>
#

declare -A OFMANAGER_OPERATION_USAGE=(
    [TOOL_NAME]="__of_operation"
    [ARG1]="[OPERATION] start | stop | restart | status | version"
    [EX-PRE]="# Start OpenOffice service"
    [EX]="__of_operation start"
)

#
# @brief  Run operation on OpenOffice service
# @param  Value required operation to be done
# @retval Success return 0, else return 1
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# OP="start"
# __of_operation "$OP"
# STATUS=$?
#
# if [ $STATUS -eq $SUCCESS ]; then
#    # true
# else
#    # false
# fi
#
function __of_operation {
    local OP=$1
    if [ -n "${OP}" ]; then
        local FUNC=${FUNCNAME[0]} MSG="None" STATUS
        MSG="Run operation [${OP}]"
        info_debug_message "$MSG" "$FUNC" "$OF_MANAGER_TOOL"
        local SYSCTL=${config_of_manager_util[SYSTEMCTL]}
        if [ "${OP}" == "restart" ]; then
            eval "${SYSCTL} stop openoffice.service"
            sleep 2
            eval "${SYSCTL} start openoffice.service"
        else
            eval "${SYSCTL} $OP openoffice.service"
        fi
        info_debug_message_end "Done" "$FUNC" "$OF_MANAGER_TOOL"
        return $SUCCESS
    fi
    usage OFMANAGER_OPERATION_USAGE
    return $NOT_SUCCESS
}

