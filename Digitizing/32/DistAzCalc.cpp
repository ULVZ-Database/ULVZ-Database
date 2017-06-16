#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<string>

using namespace std;

double gcpdistance(double,double,double,double);
void waypoint(double,double,double,double,double,double *,double *);
double center_az(double,double,double,double);

int main(int argc, char **argv){

	// Event center and statoin center.
    double EV_LON=-28;
    double EV_LAT=-58;
    double ST_LON=27.5;
    double ST_LAT=-25;

	printf("%.1lf\t%.1lf\n",gcpdistance(EV_LON,EV_LAT,ST_LON,ST_LAT)
						   ,center_az(EV_LON,EV_LAT,ST_LON,ST_LAT));

    return 0;
}

double center_az(double evlo,double evla,double stlo,double stla){

	// calculate event-station center point lon/lat.
	double centerlon,centerlat,dist=gcpdistance(evlo,evla,stlo,stla);
    waypoint(evlo,evla,stlo,stla,dist/2,&centerlon,&centerlat);

	// calculate azimuth from center point to station (at center point).
	double x,y;
	double a,b,C;
	double az; 
	a=centerlat*M_PI/180;
	b=stla*M_PI/180;
	C=(stlo-centerlon)*M_PI/180;
	y=sin(C);
	x=cos(a)*tan(b)-sin(a)*cos(C);
	az=atan2(y,x);

	return az*180/M_PI;
}

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

double gcpdistance(double lo1,double la1, double lo2,double la2){

    double a,b,C,x,y;

    a=la1*M_PI/180;
    b=la2*M_PI/180;
    C=(lo1-lo2)*M_PI/180;

    y=sqrt(pow((cos(a)*sin(b)-sin(a)*cos(b)*cos(C)),2)+pow(cos(b)*sin(C),2));
    x=sin(a)*sin(b)+cos(a)*cos(b)*cos(C);

    return 180/M_PI*atan2(y,x);
}
