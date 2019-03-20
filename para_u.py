import sys
n=sys.argv
c=n[1]
s=""
print "\f"
if(c=='1'):
	s="star_u.tr"
if(c=='2'):
	s="bus_u.tr"
if(c=='3'):
	s="mesh_u.tr"
if(c=='4'):
	s="ring_u.tr"
d=[]
with open(s,"r") as f:
	for line in f:
		l=line.split(' ')
		d.append(l[0])
		s1=l[len(l)-1]
c0=d.count('d')
c1=d.count('r')
c2=d.count('+')
pdr=float(c1)/c2
print c1,c2
print pdr
print"\n\n"
print "Packet delivery ratio is ",pdr*100,"%"
print "\n\n"
print "Throughput is ",float(s1)/4.5

t=[]
ty=[]
pid=[]
dt=[]
with open(s,"r") as f:
        for line in f:
                l=line.split(" ")
                t.append(l[1])
                ty.append(l[0])
                l1=l[len(l)-1]
                l1=l1[0:len(l1)-1]
                pid.append(l1)

f.close()
p=[]
st=[]
et=[]
for i in range(len(pid)):
        p.append(pid[i])
        if(p.count(pid[i])==1):
                st.append(float(t[i]))
        elif((p.count(pid[i]))==(pid.count(pid[i]))):
                et.append(float(t[i]))

for i in range(len(et)):
        dt.append(et[i]-st[i])
jit=[]
for i in range(len(dt)-1):
	p=dt[i+1]-dt[i]
        if(p>0):
        	jit.append(float(p))

#print(dt)
#print (dt1)
sum=0
for i in range(0,len(jit)):
        sum+=jit[i]
avg=float(sum)/len(jit)
print ("THe avg jitter value is",avg)


