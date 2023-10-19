// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample2 extends StatefulWidget {
  final RequestType requestType;
  const LineChartSample2({
    super.key,
    this.requestType = RequestType.YEAR,
  });

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

enum RequestType { LAST_HOUR, TODAY, LAST_WEEK, LAST_MONTH, YEAR }

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [Color(0xFF87DFB9), Color(0xFF87C2DE)];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 32,
              left: 16,
              top: 10,
              bottom: 10,
            ),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      // fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Color(0xFF666666),
    );

    List<String> labels = [
      '1월',
      '2월',
      '3월',
      '4월',
      '5월',
      '6월',
      '7월',
      '8월',
      '9월',
      '10월',
      '11월',
      '12월'
    ];

    int interval = 1;

    switch (widget.requestType) {
      case RequestType.LAST_HOUR:
        labels = List.generate(60, (index) => '${index}분');
        interval = 5; // 5분 주기로 표시
        break;
      case RequestType.TODAY:
        labels = List.generate(24, (index) => '${index}시');
        interval = 3; // 3시간 주기로 표시
        break;
      case RequestType.LAST_WEEK:
        labels = ['일', '월', '화', '수', '목', '금', '토'];
        break;
      case RequestType.LAST_MONTH:
        labels = List.generate(30, (index) => '${index + 1}일');
        interval = 5; // 5일 주기로 표시
        break;
      case RequestType.YEAR:
        interval = 2;
        break;
    }

    if (value.toInt() < labels.length && value.toInt() % interval == 0) {
      return Text(labels[value.toInt()], style: style);
    } else {
      return const Text('', style: style);
    }
  }

  /* Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }
*/
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
      color: Color(0xFF666666),
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1만';
        break;
      case 3:
        text = '9만';
        break;
      case 5:
        text = '14만';
        break;
      case 7:
        text = '17만';
        break;
      case 9:
        text = '30만';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xFFC6C6C6),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.grey,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
