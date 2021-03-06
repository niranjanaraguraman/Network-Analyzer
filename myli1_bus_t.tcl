#Create a simulator object
set ns [new Simulator]
$ns color 1 Red

#Open the nam trace file
set nf [open bus_t.nam w]
$ns namtrace-all $nf

set nt [open bus_t.tr w]
$ns trace-all $nt

#Define a 'finish' procedure
proc finish {} {
    global ns nf
    $ns flush-trace
    #Close the trace file
    close $nf
    #Executenam on the trace file
    exec ~/ns-allinone-2.35/ns-2.35/nam bus_t.nam
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
set tcp0 [new Agent/TCP]
$tcp0 set class_ 1
$ns attach-agent $n0 $tcp0
$tcp0 set fid_ 1
#Create a TCP Sink agent (a traffic sink) for TCP and attach it to node n3
set sink0 [new Agent/TCPSink]
$ns attach-agent $n3 $sink0
#Connect the traffic sources with the traffic sink
$ns connect $tcp0 $sink0

# Create a CBR traffic source and attach it to tcp0
set ftp0 [new Application/FTP]
$ftp0 set packetSize_ 1000
$ftp0 set interval_ 0.01
$ftp0 attach-agent $tcp0
$ftp0 set type_ FTP

#Schedule events for the CBR agents
$ns at 0.1 "$ftp0 start"
$ns at 4.5 "$ftp0 stop"


#Call the finish procedure after 5 seconds of simulation time
$ns at 5.0 "finish"

#Run the simulation
$ns run
