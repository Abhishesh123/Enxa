import 'package:enxa/values/customColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';



class CPieChart extends StatelessWidget {
  Map<String, double> dataMap = new Map();
  List<Color> colors=List();
  CPieChart({this.dataMap,this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/1.4,
      height: MediaQuery.of(context).size.width/1.4,
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: PieChart(
        dataMap: dataMap,
        animationDuration: Duration(seconds: 2),
        chartLegendSpacing: 35.0,
        chartRadius: MediaQuery.of(context).size.width*.5,
        showChartValuesInPercentage: true,
        showChartValues: true,
        showChartValuesOutside: false,
        chartValueBackgroundColor: Colors.grey[200],
        colorList: colors,
        showLegends: true,
        legendStyle: GoogleFonts.muli(color: customColor.white,fontSize: 10),
        legendPosition: LegendPosition.right,
        decimalPlaces: 0,
        showChartValueLabel: true,
        initialAngle: 0,
        chartValueStyle: defaultChartValueStyle.copyWith(
          color: Colors.blueGrey[900].withOpacity(0.9),
        ),
        chartType: ChartType.ring,
      ),
    );
  }
}
