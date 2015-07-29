
:- dynamic besitzt/2,
           person/3.

person(james, 9, 2).
person(john, 8, 8).
person(harold, 10, 20).

mag(james, fussball).
mag(john, fussball).
mag(harold, buch).
mag(harold, skateboard).
                               
preis(fussball, 5).
preis(skateboard, 10).
preis(drachen, 3).
preis(buch, 6).

besitzt(james, fussball).
besitzt(harold, fussball).
besitzt(harold, drachen).
besitzt(john, skateboard).



























aelter_als(Person1, Person2) :- person(Person1, Alter1,_),
                                person(Person2, Alter2,_),
                                Alter1 > Alter2.



kann_sich_leisten(Person, Gegenstand) :- person(Person, _, Vermögen),
                                        preis(Gegenstand, Preis),
                                        Preis =< Vermögen.
                                        


moechte_haben(Person,Gegenstand) :- mag(Person, Gegenstand),
                                    not(besitzt(Person,Gegenstand)).



gib(Person, Gegenstand) :- assert(besitzt(Person, Gegenstand)).



kaufe(Person,Gegenstand) :- kann_sich_leisten(Person, Gegenstand),
                            retract(person(Person, Alter, Vermögen)),
                            preis(Gegenstand, Preis),
                            NeuesVermögen is Vermögen - Preis,
                            assert(person(Person, Alter, NeuesVermögen)),
                            assert(besitzt(Person, Gegenstand)).


                            
tausche_um_zu_bekommen(Person, Gegenstand) :- finde_partner(Person, Gegenstand1 ,AnderePerson, Gegenstand),
                                              tausche(Person, Gegenstand1 ,AnderePerson, Gegenstand).

finde_partner(Person, Gegenstand1, AnderePerson, Gegenstand) :- besitzt(Person, Gegenstand1),
                                                                besitzt(AnderePerson, Gegenstand),
                                                                not(besitzt(Person, Gegenstand)),
                                                                not(besitzt(AnderePerson, Gegenstand1)),
                                                                not(mag(Person, Gegenstand1)),
                                                                not(mag(AnderePerson, Gegenstand)).
                                                                
tausche(Person, Gegenstand1, AnderePerson, Gegenstand) :- retract(besitzt(Person, Gegenstand1)),
                                                          retract(besitzt(AnderePerson, Gegenstand)),
                                                          assert(besitzt(Person, Gegenstand)),
                                                          assert(besitzt(AnderePerson, Gegenstand1)).
                                                          
                                                          

erlange(Person, Gegenstand) :- kaufe(Person, Gegenstand).
erlange(Person, Gegenstand) :- tausche_um_zu_bekommen(Person, Gegenstand).






                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
