#Create a simulator object
set ns [new Simulator]
#Define different colors for data flows (for NAM)

$ns color 1 Orange
#Open the nam trace file
set nf [open bus_u.nam w]
$ns namtrace-all $nf

set nt [open bus_u.tr w]
$ns trace-all $nt

#Define a 'finish' procedure
proc finish {} {
    global ns nf nt
    $ns flush-trace
    #Close the trace file
    close $nf
    close $nt
    #Executenam on the trace file
    exec ~/ns-allinone-2.35/ns-2.35/nam bus_u.nam
    exit 0
}

#Create four nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

#CreateLanbetween the nodes
set lan0 [$ns newLan "$n0 $n1 $n2 $n3 $n4 $n5" 0.5Mb 230ms LL Queue/DropTail MAC/Csma/Cd Channel]
#$ns link-op $lan0 $n4 orient right-down
#Create a TCP agent and attach it to node n1
set udp0 [new Agent/UDP]
$udp0 set class_ 1
$ns attach-agent $n0 $udp0
#Create a TCP Sink agent (a traffic sink) for TCP and attach it to node n3
set null [new Agent/Null]
$ns attach-agent $n3 $null
#Connect the traffic sources with the traffic sink
$ns connect $udp0 $null
$udp0 set fid_ 1
# Create a CBR traffic source and attach it to tcp0
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 1000
$cbr0 set interval_ 0.01
$cbr0 attach-agent $udp0

#$cbr0 set type_ CBR

#Schedule events for the CBR agents
$ns at 0.1 "$cbr0 start"
$ns at 4.5 "$cbr0 stop"


#Call the finish procedure after 5 seconds of simulation time
$ns at 5.0 "finish"

#Run the simulation
$ns run
