puts "Enter your choice 1.TCP 2.UDP"
set choice [gets stdin]
if { $choice==1 } {
puts "Enter the total number of topologies to be compared"
set n [gets stdin]

for  {set k 0} {$k < $n } {incr k} {
puts '1.Star'
puts '2.Bus'
puts '3.Mesh'
puts '4.Ring'
set c [gets stdin]

if { $c==1 } {
	exec ~/ns-allinone-2.35/ns-2.35/nam star_t.nam
	exec xgraph star_t.txt star_u.txt -geometry 8000x4000 &
} elseif { $c==2 } {
       	exec ~/ns-allinone-2.35/ns-2.35/nam bus_t.nam
	exec xgraph bus_t.txt bus_u.txt -geometry 8000x4000 &
} elseif { $c==3 } {
        exec ~/ns-allinone-2.35/ns-2.35/nam mesh_t.nam
	exec xgraph mesh_t.txt mesh_u.txt -geometry 8000x4000 &
} else {
	exec ~/ns-allinone-2.35/ns-2.35/nam ring_t.nam
	exec xgraph ring_t.txt ring_u.txt -geometry 8000x4000 &
}
exec python para_t.py $c &
}
} elseif { $choice==2 } {
puts "Enter the total number of topologies to be compared"
set n [gets stdin]

for  {set k 0} {$k < $n } {incr k} {
puts '1.Star'
puts '2.Bus'
puts '3.Mesh'
puts '4.Ring'
set c [gets stdin]

if { $c==1 } {
        exec ~/ns-allinone-2.35/ns-2.35/nam star_u.nam
	exec xgraph star_t.txt star_u.txt -geometry 8000x4000 &
} elseif { $c==2 } {
        exec ~/ns-allinone-2.35/ns-2.35/nam bus_u.nam
	exec xgraph bus_t.txt bus_u.txt -geometry 8000x4000 &
} elseif { $c==3 } {
        exec ~/ns-allinone-2.35/ns-2.35/nam mesh_u.nam
	exec xgraph mesh_t.txt mesh_u.txt -geometry 8000x4000 &
} else {
        exec ~/ns-allinone-2.35/ns-2.35/nam ring_u.nam
	exec xgraph ring_t.txt ring_u.txt -geometry 8000x4000 &
}
exec python para_u.py $c &
}
}

exec xgraph star_t.txt bus_t.txt mesh_t.txt ring_t.txt  -geometry 8000x4000 &
exec xgraph star_u.txt bus_u.txt mesh_u.txt ring_u.txt  -geometry 8000x4000 &

