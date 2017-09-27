#include<stdlib.h>
#include<iostream>
#include<fstream>
#include<cmath>

using namespace std;

void waypoint(double EVLO,double EVLA,double stlo, double stla,double dist,double *plo,double *pla){

    // Step 1. Calculate azimuth from event to station. (azimuth is centered on event)
    double x,y;
    double a,b,C;
    double az;
    a=EVLA*M_PI/180;
    b=stla*M_PI/180;
    C=(stlo-EVLO)*M_PI/180;
    y=sin(C);
    x=cos(a)*tan(b)-sin(a)*cos(C);
    az=atan2(y,x);

    // Step 2.
    // Extend great circle arc from station to event, till it cross equator at point P.
    // Calculate azimuth from P to event (or station). (azimuth is centered on P)
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

    return;
}

int main(int argc, char *argv[]){

	double evlo=atof(argv[1]),evla=atof(argv[2]);
	double stlo=atof(argv[3]),stla=atof(argv[4]);
	double srcdeg=atof(argv[5]);
	double backward=atof(argv[6]),foreward=atof(argv[7]);
	double lon1,lat1,lon2,lat2;

	waypoint(evlo,evla,stlo,stla,srcdeg-backward,&lon1,&lat1);
	waypoint(evlo,evla,stlo,stla,srcdeg+foreward,&lon2,&lat2);
	cout << lon1 << " " << lat1 << endl;
	cout << lon2 << " " << lat2 << endl;

	return 0;
}
