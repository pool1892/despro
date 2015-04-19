#Ich nehme an, dass 0 keine erlaubte Zahl für die Fragestellung ist, 100 hingegen schon. (also 100-18 ist ok, aber 0+18 ist es nicht)
import numpy as np
import random as random

#Make arrays
add=np.zeros((101,101))
sub=np.zeros((101,101))
add[0][0]=1
#write results to arrays
for i in range(101):
    for j in range(101):
        add[i][j]=i+j
        sub[i][j]=i-j

#Add
def addtest():
    a=0
    while a==0:
        x=random.randint(1,100)
        y=random.randint(1,100)
        if add[x][y]<101:
            print ("Berechne "+ str(x)+ " + " +str(y)+" = ______________\n" )
            a=1
    return

#Subtract 
def subtest():
    a=0
    while a==0:
        x=random.randint(1,100)
        y=random.randint(1,100)
        if sub[x][y]>0:
            print ("Berechne "+ str(x)+ " - " +str(y)+" = ______________\n" )
            a=1
    return
def randdraw():
    x=random.randint(0,1)
    if x==0: 
        addtest()
    if x==1: 
        subtest()
    return
#Demooutput
for i in range(20):
    randdraw()