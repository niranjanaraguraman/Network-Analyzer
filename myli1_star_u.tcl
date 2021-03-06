set ns [new Simulator]

$ns color 1 Orange

set nt [open star_u.tr w]
set nf [open star_u.nam w]

$ns namtrace-all $nf
$ns trace-all  $nt

proc finish {} {

        global ns nf nt
        $ns flush-trace
        close $nf
	close $nt
        exec ~/ns-allinone-2.35/ns-2.35/nam star_u.nam
	exit 0

}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

$ns duplex-link $n0 $n2 2Mb 20ms DropTail
$ns duplex-link $n1 $n2 2Mb 20ms DropTail
$ns duplex-link $n2 $n3 2Mb 20ms DropTail
$ns duplex-link $n2 $n4 1.7Mb 20ms DropTail
$ns duplex-link $n2 $n5 1.7Mb 20ms DropTail

#Set Queue Size of link (n2-n3) to 10


$ns queue-limit $n2 $n3 10

$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient right-up
$ns duplex-link-op $n2 $n3 orient right-up
$ns duplex-link-op $n2 $n4 orient right-down
$ns duplex-link-op $n2 $n5 orient right

#Monitor the queue for link (n2-n3). (for NAM)

$ns duplex-link-op $n2 $n3 queuePos 0.5

#Setup a TCP connection

set udp [new Agent/UDP]
$udp set class_ 1
$ns attach-agent $n0 $udp

set null [new Agent/Null]
$ns attach-agent $n3 $null

$ns connect $udp $null
$udp set fid_ 1

#Setup a CBR over TCP connection

set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 1000
$cbr0 set interval_ 0.01
$cbr0 attach-agent $udp
#$ftp0 set type_FTP

#Schedule events for the CBR and FTP agents           
$ns at 0.1 "$cbr0 start"
$ns at 4.5 "$cbr0 stop"

#Call the finish procedure after 5 seconds of simulation time

$ns at 5.0 "finish"

#Run the simulation

$ns run


