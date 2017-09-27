#include<iostream>
#include<string>
#include<cmath>

using namespace std;

void waypoint_az(double,double,double,double,double *,double *);

int main(int argc, char **argv){

	double lon=stod(argv[1]);
	double lat=stod(argv[2]);
	double radius=stod(argv[3]);
	double plo,pla;


	for (double az=360;az>0.1;az-=1){
		waypoint_az(lon,lat,az,radius,&plo,&pla);
		cout << plo << " " << pla << endl;
	}

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
