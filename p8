set val(chan) Channel/WirelessChannel
set val(prop) Propagation/TwoRayGround
set val(netif) Phy/WirelessPhy
set val(mac) Mac/802_11
set val(ifq) Queue/DropTail/PriQueue
set val(ll) LL
set val(ant) Antenna/OmniAntenna
set val(x) 500
set val(y) 500
set val(ifqlen) 50
set val(nn) 50
set val(stop) 100.0
set val(rp) AODV
set val(sc) "mobile"
set val(cp) "transmit"

set ns [new Simulator]
set tf [open 003.tr w]
$ns trace-all $tf
set nf [open 003.nam w]
$ns namtrace-all-wireless $nf $val(x) $val(y)
set prop [new $val(prop)]
set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)
set god_ [create-god $val(nn)]

$ns node-config -adhocRouting $val(rp) \
-llType $val(ll) \
-macType $val(mac) \
-ifqType $val(ifq) \
-ifqLen $val(ifqlen) \
-antType $val(ant) \
-propType $val(prop) \
-phyType $val(netif) \
-channelType $val(chan) \
-topoInstance $topo \
-agentTrace ON \
-routerTrace ON \
-macTrace ON

for {set i 0} {$i < $val(nn) } {incr i} {
    set node_($i) [$ns node]
    $node_($i) random-motion 0
}
for {set i 0} {$i < $val(nn) } {incr i} {
    set xx [expr rand()*500]
    set yy [expr rand()*400]
    $node_($i) set X_ $xx
    $node_($i) set Y_ $yy
}
#Initial Positions of Nodes
for {set i 0} {$i < $val(nn)} {incr i} {
    $ns initial_node_pos $node_($i) 40
}
#puts "Loading scenario file..."
#source $val(sc)
puts "Loading connection file..."
source $val(cp)

for {set i 0} {$i < $val(nn) } {incr i} {
    $ns at $val(stop) "$node_($i) reset";
}
proc finish {} {
global ns tf nf
$ns flush-trace
close $tf
close $nf
exec nam 003.nam &
exit 0
}
$ns run

Desktop> ns-2.35all_in_one >ns-2.35>>indeputils>cmu-scen-gen>cbrgen.tcl nodes: 50, max conn: 25, send rate: 20.0, seed: 1.0
Desktop>ns-2.35all_in_one>ns-2.35>indeputils>cmu-scengen>setdest>setdest.h version: 1, nodes: 50, pause: 1.00, max time: 100.0, max speed: 20.00, max x: 500.00, max y: 500.00

 
Desktop>ns-2.35all_in_one>ns-2.35>indeputils>cmu-scengen>setdest>setdest.h version: 1, nodes: 50, pause: 1.00, max time: 100.0, max speed: 20.00, max x: 500.00, max y: 500.00
