#Create a simulator object
set ns [new Simulator]

$ns color 1 Orange
#Open the nam trace file
set nf [open mesh_u.nam w]
$ns namtrace-all $nf

set nt [open mesh_u.tr w]
$ns trace-all $nt

#Define a 'finish' procedure
proc finish {} {
    global ns nf nt
    $ns flush-trace
    #Close the trace file
    close $nf
    close $nt

    #Executenam on the trace file
    exec ~/ns-allinone-2.35/ns-2.35/nam mesh_u.nam
    exit 0
}

#Create four nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
#Create links between the nodes
$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n0 $n2 1Mb 10ms DropTail
$ns duplex-link $n0 $n3 1Mb 10ms DropTail
$ns duplex-link $n0 $n4 1Mb 10ms DropTail
$ns duplex-link $n0 $n5 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n1 $n3 1Mb 10ms DropTail
$ns duplex-link $n1 $n4 1Mb 10ms DropTail
$ns duplex-link $n1 $n5 1Mb 10ms DropTail
$ns duplex-link $n2 $n3 1Mb 10ms DropTail
$ns duplex-link $n2 $n4 1Mb 10ms DropTail
$ns duplex-link $n2 $n5 1Mb 10ms DropTail
$ns duplex-link $n3 $n4 1Mb 10ms DropTail
$ns duplex-link $n3 $n5 1Mb 10ms DropTail
$ns duplex-link $n4 $n5 1Mb 10ms DropTail

#Create a TCP agent and attach it to node n0
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

#Schedule events for the CBR agents
$ns at 0.1 "$cbr0 start"
$ns at 4.5 "$cbr0 stop"

#Call the finish procedure after 5 seconds of simulation time
$ns at 5.0 "finish"

#Run the simulation
$ns run

