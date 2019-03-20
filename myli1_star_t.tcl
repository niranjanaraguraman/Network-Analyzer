set ns [new Simulator]

$ns color 1 Red
$ns color 2 Green

set nt [open star_t.tr w]
set nf [open star_t.nam w]

$ns namtrace-all $nf
$ns trace-all  $nt

proc finish {} {

        global ns nf nt
        $ns flush-trace
        close $nf
	close $nt
        exec ~/ns-allinone-2.35/ns-2.35/nam star_t.nam
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


$ns queue-limit $n2 $n3 1

$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient right-up
$ns duplex-link-op $n2 $n3 orient right-up
$ns duplex-link-op $n2 $n4 orient right-down
$ns duplex-link-op $n2 $n5 orient right

#Monitor the queue for link (n2-n3). (for NAM)

$ns duplex-link-op $n2 $n3 queuePos 0.5

#Setup a TCP connection

set tcp [new Agent/TCP]
$tcp set class_ 1
$ns attach-agent $n0 $tcp

set sink [new Agent/TCPSink]
$ns attach-agent $n3 $sink

$ns connect $tcp $sink
$tcp set fid_ 1

#Setup a CBR over TCP connection

set ftp0 [new Application/FTP]
$ftp0 set packetSize_ 1000
$ftp0 set interval_ 0.01
$ftp0 attach-agent $tcp
#$ftp0 set type_FTP

#Schedule events for the CBR and FTP agents           
$ns at 0.1 "$ftp0 start"
$ns at 4.5 "$ftp0 stop"

#Call the finish procedure after 5 seconds of simulation time

$ns at 5.0 "finish"

#Run the simulation

$ns run


