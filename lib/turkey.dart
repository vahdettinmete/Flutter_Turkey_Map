import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_drawing/path_drawing.dart';
import 'ilHaber.dart';
import 'turkeymapSVG.dart';


class TurkeyMaps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title:Image.asset(
            "images/pngwing.com.png",
            width: 180,
            height: 30,
            fit: BoxFit.cover,
          ),
           leading: IconButton(
          icon: Icon(Icons.home,
          size: 30,
          color: Colors.white,),
          onPressed: () {
          }
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(20, 30, 48, 1),
          titleSpacing: 1.0,
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: const Maps(),
        ));
  }
}

String Sehirs="";

class Maps extends StatefulWidget {
  const Maps();

  @override
  _MapsState createState() => _MapsState();
}

final notifier = ValueNotifier(Offset.zero);

class _MapsState extends State<Maps> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0, left: 0, right: 0),
        child: GestureDetector(
          onTapUp: (e) {
            notifier.value = e.localPosition;
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => IlNews(Sehirs.toString())));
            });
          },
          child: CustomPaint(
            willChange: true,
            isComplex: true,
            painter: MapPainter(notifier),
            child: SizedBox.expand(),
          ),
        ),
      ),
    );
  }
}


class Shape {
  Shape(strPath, this.label, this._color) : _path = parseSvgPathData(strPath);

  void transform(Matrix4 matrix) =>
      _transformedPath = _path.transform(matrix.storage);
  
  final Path _path;
  late Path _transformedPath;
  final String label;
  final Color _color;

}

class MapPainter extends CustomPainter {
   MapPainter(this._notifier) : super(repaint: _notifier);

  final navigatorKey = GlobalKey<NavigatorState>();

  final ValueNotifier<Offset> _notifier;
  
  final Paint _paint = Paint();
  Size _size = Size.zero;

  @override
  paint(Canvas canvas, Size size) {
    if (size != _size) {
      _size = size;
      final fs = applyBoxFit(BoxFit.fitWidth, Size(1000, 10), size);
      final r = Alignment.center.inscribe(fs.destination, Offset.zero & size);
      final matrix = Matrix4.translationValues(r.left, r.top, 0)
        ..scale(fs.destination.width / fs.source.width);
      for (var shape in shapes) {
        shape.transform(matrix);
      }
      print( '$_size');
    }

    canvas
      ..clipRect(Offset.zero & size)
      ..drawColor(Colors.white, BlendMode.src);
    var selectedShape;
    for (var shape in shapes) {
      final path = shape._transformedPath;
      final selected = path.contains(_notifier.value);

      _paint
        ..color = selected ? Colors.blue : shape._color
        ..style = PaintingStyle.fill;
      canvas.drawPath(path, _paint);
      selectedShape ??= selected ? shape : null;

      _paint
        ..color = Colors.white
        ..strokeWidth = 0.5
        ..style = PaintingStyle.stroke;
      canvas.drawPath(path, _paint);
    }
    if (selectedShape != null) {
      _paint
        ..color = Colors.black
        ..maskFilter = MaskFilter.blur(BlurStyle.outer, 12)
        ..style = PaintingStyle.fill;
      canvas.drawPath(selectedShape._transformedPath, _paint);
      _paint.maskFilter = null;

      final builder = ui.ParagraphBuilder(ui.ParagraphStyle(
        fontSize: 14,
        fontFamily: 'Roboto',
      ))
        ..pushStyle(ui.TextStyle(
          color: Colors.white,
           shadows: kElevationToShadow[1],
        ))
        ..addText(selectedShape.label);

      final paragraph = builder.build()
        ..layout(ui.ParagraphConstraints(width: size.width));
      canvas.drawParagraph(paragraph, _notifier.value.translate(0, -32));
      var Country = selectedShape.label;
      print("Selected Country:" + Country);
      if (Country != null) {
        return Sehir(Country);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

dynamic Sehir(country) {

  Sehirs = country.toString();
  return Sehirs;
}
