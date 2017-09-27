#include<iostream>
#include<fstream>
#include<cmath>

using namespace std;

double getAz(double EVLO,double EVLA,double stlo,double stla){
	// Input and outputs in degree.

    double x,y,a,b,C,az;
    a=EVLA*M_PI/180;
    b=stla*M_PI/180;
    C=(stlo-EVLO)*M_PI/180;
    y=sin(C);
    x=cos(a)*tan(b)-sin(a)*cos(C);
    az=atan2(y,x)*180/M_PI;

	return az;
}

int main(){


	ifstream fpin("HITLO_HITLA_STLO_STLA");

	double hitlo,hitla,stlo,stla,avg_az=0;
	int Cnt=0;
	while(fpin >> hitlo >> hitla >> stlo >> stla){
		avg_az+=getAz(hitlo,hitla,stlo,stla);
		Cnt++;
	}
	cout << "Average azimuth at bouncing point: " << avg_az/Cnt << endl;

	fpin.close();
	
	return 0;
}
