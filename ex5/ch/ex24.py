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
def addtest(z):
    a=0
    while a==0:
        x=random.randint(1,100)
        y=random.randint(1,100)
        if z[x][y]<101:
            print ("Berechne "+ str(x)+ " + " +str(y)+" = ______________\n" )
            l=input("Deine Antwort: ")
            if l==x+y:
            	print ("Richtig")
            else:
            	print("Falsch")
            a=1
            z[x][y]=200
            z[y][x]=200
    return

#Subtract 
def subtest(z):
    a=0
    while a==0:
        x=random.randint(1,100)
        y=random.randint(1,100)
        if z[x][y]>0:
            print ("Berechne "+ str(x)+ " - " +str(y)+" = ______________\n" )
            l=input("Deine Antwort: ")
            if l==x-y:
            	print ("Richtig")
            else:
            	print("Falsch")
            a=1
            z[x][y]=0
    return
def randdraw(y,z):
    x=random.randint(0,1)
    if x==0: 
        addtest(y)
    if x==1: 
        subtest(z)
    return
#Demooutput
def game(x):
	add2=add
	sub2=sub
	for i in range(x):
		randdraw(add2, sub2)
game(20)
## Funktioniert natürlich nur mit Zahleingaben, zu faul für errorhandling
