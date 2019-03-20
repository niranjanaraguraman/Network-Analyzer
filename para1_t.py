t=[]
ty=[]
pid=[]

with open("bus_u.tr","r") as f:
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

f=open("bus_u.txt","w")

dt=[]
for i in range(len(st)):
	s=""
	dt.append(et[i]-st[i])
	s=s+str(i)+" "+str(dt[i])+"\n"
	f.write(s)
f.close()

"""dt1=[]
for i in range(0,len(dt)):
	h=round(dt[i],4)
	dt1.append(h)
"""
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

