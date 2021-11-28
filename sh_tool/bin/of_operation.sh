#!/bin/bash
#
# @brief   Open Office Manager
# @version ver.2.0
# @date    Sun 28 Nov 2021 08:24:52 AM CET
# @company None, free software to use 2021
# @author  Vladimir Roncevic <elektron.ronca@gmail.com>
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

