<#--
THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.
-->
<#assign hostForUrl=container.host.address?string>
<#if container.hostname?has_content>
	<#assign hostForUrl=container.hostname>
</#if>
<#assign adminUrl = container.protocol + "://" + hostForUrl + ":" + container.port>

<#list container.wlstProperties as prop>
    key=$(echo ${prop} | cut -f1 -d=)
    val=$(echo ${prop} | cut -f2 -d=)
    echo "${r"${key}"} = ${r"${val}"}" 
    echo "${r"${key}"}=${r"${val}"}" >> /tmp/wlst.properties
</#list>
echo "======================================="

export DEPLOYIT_WLST_PASSWORD=${container.password}
${container.getWlstPath()} -i ${script} ${container.username} ${adminUrl}
res=$?
if [ $res != 0 ] ; then
	exit $res
fi
rm /tmp/wlst.properties


