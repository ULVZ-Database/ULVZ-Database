#include<iostream>
#include<fstream>
#include<cmath>

using namespace std;

double GetAz(double evlo,double evla,double stlo,double stla){

    double x,y,a,b,C;

    a=evla*M_PI/180;
    b=stla*M_PI/180;
    C=(stlo-evlo)*M_PI/180;
    y=sin(C);
    x=cos(a)*tan(b)-sin(a)*cos(C);

    return atan2(y,x)*180/M_PI;
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

int main(int argc, char *argv[]){

	ifstream fpin1(argv[1]);
	ifstream fpin2(argv[2]);
	ofstream fpout(argv[3]);

	double lon1,lat1,lon2,lat2,plon,plat;
	double model_halfwidth=165/2/60.737;

	while(fpin1 >> lon1 >> lat1){
		fpin2 >> lon2 >> lat2;
		double az=GetAz(lon1,lat1,lon2,lat2);
// 		if (az>90) az-=90;

		waypoint_az(lon1,lat1,az,model_halfwidth,&plon,&plat);
		fpout << plon << " " << plat << endl;
		waypoint_az(lon1,lat1,az+180,model_halfwidth,&plon,&plat);
		fpout << plon << " " << plat << endl;
		fpout << ">" << endl;
	}
	fpin1.close();
	fpin2.close();
	fpout.close();

	return 0;
}
