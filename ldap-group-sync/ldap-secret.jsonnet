function (
	bindPasswordBase64="changeme",
	url="ldap://corp.npss.ae:389",
	bindDN="CN=OpenShiftBind,OU=Service Accounts,OU=Users,OU=NPSS,DC=corp,DC=npss,DC=ae",
	groupBaseDN="OU=AZ2Core,OU=OpenShift Groups,OU=Groups,OU=NPSS,DC=corp,DC=npss,DC=ae",
	userBaseDN="DC=corp,DC=npss,DC=ae"
)

[{
    "apiVersion": "v1",
    "data": {
        "bindPassword": bindPasswordBase64
    },
    "kind": "Secret",
    "metadata": {
        "name": "ldap-bind-password",
        "namespace": "ldap-group-sync",
    },
    "type": "Opaque"
}]
