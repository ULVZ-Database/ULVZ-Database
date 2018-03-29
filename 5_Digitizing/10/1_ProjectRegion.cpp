#include<iostream>
#include<fstream>
#include<cmath>
#include<algorithm>
#include<tuple>

#include<GridStretch.hpp>
#include<PointInPolygon.hpp>

using namespace std;

int main(){

	double x,y;
	vector<pair<double,double>> gd;
	ifstream fpin("3_Grid.txt");
	while(fpin >> x >> y){
		gd.push_back({x,y});
	}
	fpin.close();


	vector<pair<double,double>> ld;
	fpin.open("1_Area1.txt");
	while(fpin >> x >> y){
		ld.push_back({x,y});
	}
	fpin.close();


	vector<pair<int,int>> ldx;
	ldx.resize(ld.size());
	for (int i=0;i<40;i++){
		for (int j=0;j<20;j++){

			double ul=j*41+i,bl=ul+41;

			vector<pair<double,double>> Polygon;
			Polygon.push_back(gd[ul]);
			Polygon.push_back(gd[bl]);
			Polygon.push_back(gd[bl+1]);
			Polygon.push_back(gd[ul+1]);

            vector<bool> ans;
            for (const auto &item: ld) ans.push_back(PointInPolygon(Polygon,item));

			for (size_t k=0;k<ans.size();k++){
				if (ans[k]){
					ldx[k]={i,j};
				}
			}
		}
	}


	vector<pair<double,double>> Ans;
	for (size_t k=0;k<ld.size();k++){

		int i,j;
		tie(i,j)=ldx[k];

		x=20+i*0.5;
		y=62-j*0.5;
		double ul=j*41+i,bl=ul+41;


		vector<pair<double,double>> Polygon;
		Polygon.push_back(gd[ul]);
		Polygon.push_back(gd[bl]);
		Polygon.push_back(gd[bl+1]);
		Polygon.push_back(gd[ul+1]);

		auto ans=GridStretch(Polygon,ld[k]);

		Ans.push_back({x+ans.first*0.5,y-0.5+ans.second*0.5});
	}

	for (int k=0;k<5;k++){
		auto tmp_pair=Ans[0];
		for (size_t i=1;i<Ans.size();i++){
			Ans[i-1].first=(Ans[i-1].first+Ans[i].first)/2;
			Ans[i-1].second=(Ans[i-1].second+Ans[i].second)/2;
		}
		Ans.back().first=(Ans.back().first+tmp_pair.first)/2;
		Ans.back().second=(Ans.back().second+tmp_pair.second)/2;
	}

	ofstream fpout("1_Area1.area");
	for (size_t i=0;i<Ans.size();i++)
		fpout << Ans[i].first << " " << Ans[i].second << endl;
	fpout.close();

	return 0;
}
