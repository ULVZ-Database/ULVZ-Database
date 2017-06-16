#include<iostream>
#include<fstream>
#include<cmath>
#include<algorithm>
#include<tuple>
#include<ASU_tools.hpp>

using namespace std;

int main(){

	double x,y;
	vector<pair<double,double>> gd;
	ifstream fpin("3_Grid2.txt");
	while(fpin >> x >> y){
		gd.push_back({x,y});
	}
	fpin.close();


	vector<pair<double,double>> ld;
	fpin.open("3_Area4.txt");
	while(fpin >> x >> y){
		ld.push_back({x,y});
	}
	fpin.close();


	vector<pair<int,int>> ldx;
	ldx.resize(ld.size());
	for (int i=0;i<20;i++){
		for (int j=0;j<12;j++){

			double ul=j*21+i,bl=ul+21;

			vector<pair<double,double>> Polygon;
			Polygon.push_back(gd[ul]);
			Polygon.push_back(gd[bl]);
			Polygon.push_back(gd[bl+1]);
			Polygon.push_back(gd[ul+1]);

			auto ans=PointsInPolygon(Polygon,ld);

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

		x=15+i*0.5;
		y=70-j*0.25;
		double ul=j*21+i,bl=ul+21;


		vector<pair<pair<double,double>,pair<double,double>>> Polygon;
		Polygon.push_back({gd[ul],{x,y}});
		Polygon.push_back({gd[bl],{x,y-0.25}});
		Polygon.push_back({gd[bl+1],{x+0.5,y-0.25}});
		Polygon.push_back({gd[ul+1],{x+0.5,y}});

		auto ans=GridStretch(Polygon,ld[k]);

		Ans.push_back(ans);
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

	ofstream fpout("3_Area4.area");
	for (size_t i=0;i<Ans.size();i++)
		fpout << Ans[i].first << " " << Ans[i].second << endl;
	fpout.close();

	return 0;
}
