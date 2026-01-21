function (
  bindPasswordBase64 = "changeme",
  url = "ldap://corp:389",
  bindDN = "CN=OpenShiftBind,OU=Service Accounts",
  groupBaseDN = "OU=AZ2Core,OU=OpenShift Groups",
  userBaseDN = "DC=corp,DC=npss,DC=ae"
)
[
  {
    apiVersion: "v1",
    kind: "ConfigMap",
    metadata: {
      name: "ldap-group-syncer",
      namespace: "ldap-group-sync",
      labels: {
        app: "cronjob-ldap-group-sync",
      },
    },
    data: {
      "ldap-group-sync.yaml": |||
        apiVersion: v1
        kind: LDAPSyncConfig
        url: ${url}
        bindDN: ${bindDN}
        bindPassword:
          file: /etc/secrets/bindPassword
        insecure: false
        ca: /etc/ldap-ca/ca.crt
        augmentedActiveDirectory:
          groupsQuery:
            baseDN: "Ou=SIB - Groups, dc=sib, dc=loca1"
            scope: sub
            derefAliases: never
            pagesize: 0
          groupUIDAttribute: dn
          groupNameAttributes: [ cn ]
          groupMembershipAttributes: [ memberof ]
          usersQuery:
            baseDN: "DC=sib,DC=local"
            scope: sub
            filter: (objectClass=person)
            derefAliases: never
            pagesize: 0
          userNameAttributes: [ sAMAccountName ]
      |||,
    },
  },
]

