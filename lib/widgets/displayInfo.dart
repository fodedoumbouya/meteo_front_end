import 'package:flutter/material.dart';
import 'package:meteo_front_end/base/base_widget.dart';
import 'package:meteo_front_end/widgets/charts/line_chart.dart';

class DisplayInfo extends BaseWidget {
  const DisplayInfo({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _DisplayInfoState();
  }
}

class _DisplayInfoState extends BaseWidgetState<DisplayInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: c(
        h: sh(),
        w: sw(),
        child: Stack(
          children: [
            Positioned(
                top: yy(100),
                right: xx(50),
                child: Listener(
                  onPointerDown: (event) => pop(),
                  child: c(
                      color: Colors.red,
                      boxShape: BoxShape.circle,
                      w: xx(80),
                      h: yy(80),
                      child: Icon(
                        Icons.close,
                        size: xx(80),
                      )),
                )),
            Positioned(
              top: yy(200),
              child: c(
                h: sh(),
                w: sw(),
                child: Column(
                  children: const [
                    LineChartWeather(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
