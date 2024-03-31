/*********************************************
 * OPL 20.1.0.0 Model
 
 *********************************************/

range index = 1..6;
dvar float+ B[i in 1..6,j in 1..2];
dvar float+ M[i in 1..2,j in 1..3];

float D[i in 1..2, j in 1..6]=...;
float T[i in 1..3, j in 1..2]=...;
float Demand[i in 1..6]=...;
minimize sum(i in 1..6)(D[1,i]*B[i,1]+D[2,i]*B[i,2])+sum(i in 1..2)(T[1,i]*M[i,1]+T[2,i]*M[i,2]+T[3,i]*M[i,3]);

subject to{
  C:sum(i in 1..6)(B[i,1])==8.333*(M[1,1]+M[1,2])+9.091*M[1,3];
  C1:sum(i in 1..6)(B[i,2])==8.333*(M[2,1]+M[2,2])+9.091*M[2,3];
  C2:M[1,1]+M[2,1]<=30;
  C3:M[1,2]+M[2,2]<=68;
  C4:M[1,3]+M[2,3]<=20;
  C5:sum(i in 1..6)(B[i,1])<=220;
  C6:sum(i in 1..6)(B[i,2])<=200;
  forall (i in 1..6)   P: (B[i,1]+B[i,2]>=Demand[i]);
}

	execute DISPLAY{
	  	writeln('reduced cost constraint 3 : ',C2.dual,' with slack: ',C2.slack);
	  	writeln('reduced cost constraint 4 : ',C3.dual,' with slack: ',C3.slack);
	  	writeln('reduced cost constraint 5 : ',C4.dual,' with slack: ',C4.slack);
  		for(var i in index) writeln('reduced cost for demand constraint number: ',i+5,' : ',P[i].dual,' with slack: ',P[i].slack);
  		writeln('reduced cost distribution from Ist to Antalya : ',B[4][2].reducedCost);
	  	writeln('reduced cost distribution from Ankara to Bursa : ',B[5][1].reducedCost);
	  	writeln('reduced cost transport of malt to Ist : ',M[1][3].reducedCost);
  		writeln('reduced cost transport of malt to Ankara : ',M[2][3].reducedCost);
	}
	

