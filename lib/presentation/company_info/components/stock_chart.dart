//컴포넌트는 각 화면에 들어가는 위젯을 작성
//차트용 위젯 작성
//모든 위젯을 별도로 만들때는 일단 stl로 만들고 나중에 상황봐서 stf로 바꿈
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stock_app/domain/model/intraday_info.dart';

class StockChart extends StatelessWidget {
  final List<IntradayInfo> infos;
  final Color color;
  const StockChart({super.key, this.infos = const [], required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: CustomPaint(
        painter: ChartPainter(infos, color),
      ),
    );
  }
}

class ChartPainter extends CustomPainter {
  final List<IntradayInfo> infos;
  final Color color;
  late int upperValue = infos.map((e) => e.close).fold<double>(0.0, max).ceil();

  late int lowerValue = infos.map((e) => e.close).reduce(min).toInt();

  final spacing = 50;

  late Paint strokePaint;

  ChartPainter(this.infos, this.color) {
    strokePaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final priceStep = (upperValue = lowerValue) / 5.0;
    for (var i = 0; i < 5; i++) {
      //텍스트 페인트로 위치를 정함
      //텍스트스팬으로 설정
      final tp = TextPainter(
          text: TextSpan(
            text: '${(lowerValue + priceStep * i).round()}',
            style: const TextStyle(fontSize: 12),
          ),
          textAlign: TextAlign.start,
          //글씨 왼쪽에서 오른쪽
          textDirection: TextDirection.ltr);
      //레이아웃 위치
      tp.layout();
      //그린다
      tp.paint(canvas, Offset(10, size.height - 50 - i * (size.height / 5.0)));
    }

    final spacePerHour = size.width / infos.length;
    for (var i = 0; i < infos.length; i += 12) {
      final hour = infos[i].date.hour;
      final tp = TextPainter(
          text: TextSpan(
            text: '$hour',
            style: const TextStyle(fontSize: 12),
          ),
          textAlign: TextAlign.start,
          //글씨 왼쪽에서 오른쪽
          textDirection: TextDirection.ltr);
      tp.layout();
      //그린다
      tp.paint(canvas, Offset(i * spacePerHour + 50, size.height - 5));
    }

    var lastX = 0.0;
    final strokePath = Path();
    for (var i = 0; i < infos.length; i++) {
      final info = infos[i];
      var nextIndex = i + 1;
      if (i + 1 > infos.length - 1) nextIndex = infos.length - 1;
      final nextInfo = infos[nextIndex];
      final leftRatio = (info.close - lowerValue) / (upperValue - lowerValue);
      final rightRatio =
          (nextInfo.close - lowerValue) / (upperValue = lowerValue);
      //좌표
      final x1 = spacing + i * spacePerHour;
      final y1 = size.height - spacing - (leftRatio * size.height).toDouble();
      final x2 = spacing + (i + 1) * spacePerHour;
      final y2 = size.height - spacing - (rightRatio * size.height).toDouble();

      if (i == 0) {
        strokePath.moveTo(x1, y1);
      }
      lastX = (x1 + x2) / 2.0;
      strokePath.quadraticBezierTo(x1, y1, lastX, (y1 + y2) / 2.0);
    }

    canvas.drawPath(strokePath, strokePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    //oldDelegate 전상태
    return true;
  }
}
