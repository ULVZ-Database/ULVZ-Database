#include<stdio.h>
#include<stdlib.h>
#include<math.h>

void waypoint_az(double,double,double,double,double *,double *);

int main(){

    double evlo,evla,az,az2,plo,pla;
	double dist_LWAR_left,dist_LWAR_right,dist_SSAR_left,dist_SSAR_right;
	FILE *fpout;

	// Modeling is using event 20030612. Ignore the depth.
	// Use model 1:

    evlo=154.95;
    evla=-5.97;

    dist_LWAR_left=30;
    dist_LWAR_right=42;
    dist_SSAR_left=32.5;
    dist_SSAR_right=39;

    az=60;
	az2=63;

	// Region of LWAR.
	fpout=fopen("Data.Sdiff.LWAR.may.area","w");
	for (double i=az;i<=az2;i+=0.1){
		waypoint_az(evlo,evla,i,dist_LWAR_left,&plo,&pla);
		fprintf(fpout,"%.2lf\t%.2lf\n",plo,pla);
	}
	for (double i=dist_LWAR_left;i<=dist_LWAR_right;i+=0.1){
		waypoint_az(evlo,evla,az2,i,&plo,&pla);
		fprintf(fpout,"%.2lf\t%.2lf\n",plo,pla);
	}
	for (double i=az2;i>=az;i-=0.1){
		waypoint_az(evlo,evla,i,dist_LWAR_right,&plo,&pla);
		fprintf(fpout,"%.2lf\t%.2lf\n",plo,pla);
	}
	for (double i=dist_LWAR_right;i>=dist_LWAR_left;i-=0.1){
		waypoint_az(evlo,evla,az,i,&plo,&pla);
		fprintf(fpout,"%.2lf\t%.2lf\n",plo,pla);
	}
	fclose(fpout);

	// Region of SSAR.
	fpout=fopen("Data.Sdiff.SSAR.yes.area","w");
	for (double i=az;i<=az2;i+=0.1){
		waypoint_az(evlo,evla,i,dist_SSAR_left,&plo,&pla);
		fprintf(fpout,"%.2lf\t%.2lf\n",plo,pla);
	}
	for (double i=dist_SSAR_left;i<=dist_SSAR_right;i+=0.1){
		waypoint_az(evlo,evla,az2,i,&plo,&pla);
		fprintf(fpout,"%.2lf\t%.2lf\n",plo,pla);
	}
	for (double i=az2;i>=az;i-=0.1){
		waypoint_az(evlo,evla,i,dist_SSAR_right,&plo,&pla);
		fprintf(fpout,"%.2lf\t%.2lf\n",plo,pla);
	}
	for (double i=dist_SSAR_right;i>=dist_SSAR_left;i-=0.1){
		waypoint_az(evlo,evla,az,i,&plo,&pla);
		fprintf(fpout,"%.2lf\t%.2lf\n",plo,pla);
	}
	fclose(fpout);

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
