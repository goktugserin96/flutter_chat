// import 'dart:ui';
//
// import 'package:flutter/material.dart';
//
// class Point {
//   final double x;
//   final double y;
//
//   Point(this.x, this.y);
// }
//
// class BackgroundPainter extends CustomPainter {
//   final Paint linePaint;
//   final Paint bluePaint;
//   final Paint greenPaint;
//   final Paint orangePaint;
//
//   BackgroundPainter()
//       : bluePaint = Paint()
//           ..color = Colors.lightBlue.shade300
//           ..style = PaintingStyle.fill,
//         greenPaint = Paint()
//           ..color = Colors.deepPurpleAccent
//           ..style = PaintingStyle.fill,
//         orangePaint = Paint()
//           ..color = Colors.orange.shade400
//           ..style = PaintingStyle.fill,
//         linePaint = Paint()
//           ..color = Colors.orange.shade300
//           ..style = PaintingStyle.stroke
//           ..strokeWidth = 4;
//
//   void _addPointsToPath(Path path, List<Point> points) {
//     if (points.length < 3) {
//       throw UnsupportedError('Need three or more points to create a path.');
//     }
//
//     for (var i = 0; i < points.length - 2; i++) {
//       final xc = (points[i].x + points[i + 1].x) / 2;
//       final yc = (points[i].y + points[i + 1].y) / 2;
//       path.quadraticBezierTo(points[i].x, points[i].y, xc, yc);
//     }
//
//     // connect the last two points
//     path.quadraticBezierTo(
//       points[points.length - 2].x,
//       points[points.length - 2].y,
//       points[points.length - 1].x,
//       points[points.length - 1].y,
//     );
//   }
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     paintBlue(size, canvas);
//     paintDark(size, canvas);
//     paintOrange(size, canvas);
//   }
//
//   void paintBlue(Size size, Canvas canvas) {
//     final path = Path();
//
//     path.moveTo(size.width, 0);
//
//     path.lineTo(0, 0);
//
//     path.quadraticBezierTo(
//         size.width * 0.2, size.height * 0.6, size.width, size.height * 0.4);
//
//     canvas.drawPath(path, bluePaint);
//   }
//
//   void paintDark(Size size, Canvas canvas) {
//     final path = Path();
//
//     path.moveTo(size.width, 0);
//     path.lineTo(0, 0);
//     path.lineTo(0, size.height * 0.48);
//
//     _addPointsToPath(path, [
//       Point(
//         size.width * 0.3,
//         size.height * 0.7,
//       ),
//       Point(
//         size.width * 0.7,
//         size.height * 0.1,
//       ),
//       Point(
//         size.width,
//         size.height * 0.15,
//       ),
//     ]);
//     canvas.drawPath(path, greenPaint);
//   }
//
//   void paintOrange(Size size, Canvas canvas) {
//     final path = Path();
//
//     path.moveTo(size.width * 0.75, 0);
//     path.lineTo(0, 0);
//     path.lineTo(0, size.height * 0.2);
//
//     _addPointsToPath(path, [
//       Point(
//         size.width * 0.2,
//         size.height * 0.25,
//       ),
//       Point(
//         size.width * 0.35,
//         size.height * 0.1,
//       ),
//       Point(
//         size.width * 0.65,
//         size.height * 0.06,
//       ),
//       Point(
//         size.width * 0.75,
//         0,
//       ),
//     ]);
//
//     canvas.drawPath(path, orangePaint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }
