#include<iostream>
#include<fstream>
#include<cmath>

using namespace std;

void waypoint_az(double,double,double,double,double *,double *);
double GetAz(double,double,double,double);
double gcpdistance(double,double, double,double);

int main(){

    double stlo,stla;

	// Yellow knife:
    stlo=-114.6053;
	stla=62.4932;

	double lon1,lat1,lon2,lat2;
	ifstream fpin("line_yes_calc");
	ofstream fpout("Data.Pdiff.NWP.yes.area");

	// Calculate the region.
	while (fpin >> lon1 >> lat1){
		fpin >> lon2 >> lat2;

		double baz=GetAz(stlo,stla,lon1,lat1);
		double dist1=gcpdistance(lon1,lat1,stlo,stla);
		double dist2=gcpdistance(lon2,lat2,stlo,stla);
		double plo,pla;

		for (double i=baz-2.5;i<=baz+2.5;i+=0.1){
			waypoint_az(stlo,stla,i,dist2,&plo,&pla);
			fpout << plo << " " << pla << endl;
		}
		for (double i=dist2;i<=dist1;i+=0.1){
			waypoint_az(stlo,stla,baz+2.5,i,&plo,&pla);
			fpout << plo << " " << pla << endl;
		}
		for (double i=baz+2.5;i>=baz-2.5;i-=0.1){
			waypoint_az(stlo,stla,i,dist1,&plo,&pla);
			fpout << plo << " " << pla << endl;
		}
		for (double i=dist1;i>=dist2;i-=0.1){
			waypoint_az(stlo,stla,baz-2.5,i,&plo,&pla);
			fpout << plo << " " << pla << endl;
		}
		fpout << ">" << endl;
	}
	fpin.close();
	fpout.close();

    return 0;
}

void waypoint_az(double EVLO,double EVLA,double az,double dist,double *plo,double *pla){

    // Step 1. Calculate azimuth from event to station. (azimuth is centered on event)
    double a;
    az=az*M_PI/180;
    a=EVLA*M_PI/180;

    // Step 2.
    // Extend great circle arc from station to event, till it cross equator at point P.
    // Calculate azimuth from P to event (or station). (azimuth is centered on P)
    double x,y;
    double az_p;
    y=sin(az)*cos(a);
    x=sqrt(pow(cos(az),2)+pow(sin(az),2)*pow(sin(a),2));
    az_p=atan2(y,x);

    // Step 3. Calculate the great circle distance from P to event.
    double delta_p_e;
    y=tan(a);
    x=cos(az);
    delta_p_e=atan2(y,x);

    // Step 4. Calculate longitude of point P.
    double lo_p;
    y=sin(az_p)*sin(delta_p_e);
    x=cos(delta_p_e);
    lo_p=EVLO*M_PI/180-atan2(y,x); // this may have some problem.

    // Step 5. Calculate great circle distance from point P to our destination.
    double delta;
    delta=delta_p_e+dist*M_PI/180;

    // Step 6. Calculate destination's latitude.
    y=cos(az_p)*sin(delta);
    x=sqrt(pow(cos(delta),2)+pow(sin(az_p),2)*pow(sin(delta),2));
    (*pla)=atan2(y,x);
    (*pla)*=180/M_PI;

    // Step 7. Calculate estination's longitude.
    y=sin(az_p)*sin(delta);
    x=cos(delta);
    (*plo)=lo_p+atan2(y,x);
    (*plo)*=180/M_PI;

    // Step 8. Adjust longitude to -180 < plo <= 180.

    if ((*plo)>0){
        (*plo)-=360*floor((*plo+180)/360);
    }
    else{
        (*plo)-=360*ceil((*plo-180)/360);
    }

    if ((*plo)==-180.0){
        (*plo)=180.0;
    }

    return ;
}

double GetAz(double evlo,double evla,double stlo,double stla){

    double x,y,a,b,C;

    a=evla*M_PI/180;
    b=stla*M_PI/180;
    C=(stlo-evlo)*M_PI/180;
    y=sin(C);
    x=cos(a)*tan(b)-sin(a)*cos(C);

    return atan2(y,x)*180/M_PI;
}

double gcpdistance(double lo1,double la1, double lo2,double la2){

    double a,b,C,x,y;

    a=la1*M_PI/180;
    b=la2*M_PI/180;
    C=(lo1-lo2)*M_PI/180;

    y=sqrt(pow((cos(a)*sin(b)-sin(a)*cos(b)*cos(C)),2)+pow(cos(b)*sin(C),2));
    x=sin(a)*sin(b)+cos(a)*cos(b)*cos(C);

    return 180/M_PI*atan2(y,x);
}
