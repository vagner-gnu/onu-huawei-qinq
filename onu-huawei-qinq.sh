vlan 4000 smart
#
vlan attrib 4000 q-in-q
#
port vlan 4000 0/8 3
#

ont-srvprofile gpon profile-id 4000 profile-name "VLAN_4000"
 ont-port pots 2 eth 4 catv 1 
 port vlan eth 1 transparent
 commit
#

ont-lineprofile gpon profile-id 4000 profile-name "VLAN_4000"
 omcc encrypt off
 mapping-mode port
 tcont 6 dba-profile-id 10
 gem add 6 eth tcont 6 encrypt off
 gem mapping 6 0 eth 1
 commit
 quit
#



interface gpon 0/1
ont add 15 19 sn-auth 4857544301020304 omci ont-lineprofile-id 4000 ont-srvprofile-id 4000 desc CL-L2L-QINQ
#
ont port native-vlan 15 19 eth 1 vlan 4000 priority 0
quit
#
service-port vlan 4000 gpon 0/1/15 ont 19 gemport 6 multi-service user-vlan other-all tag-transform default
quit
#