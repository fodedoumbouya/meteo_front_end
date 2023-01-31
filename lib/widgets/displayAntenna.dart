import 'package:flutter/material.dart';
import 'package:meteo_front_end/base/base_widget.dart';

class DisplayAntenna extends BaseWidget {
  const DisplayAntenna({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _DisplayAntennaState();
  }
}

class _DisplayAntennaState extends BaseWidgetState<DisplayAntenna> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7),
      body: Column(
        children: [
          c(
              h: yy(250),
              color: Colors.white,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: txtw("Liste des antennes", size: xx(70)),
                  ),
                  Positioned(
                      top: yy(150),
                      right: xx(20),
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
                ],
              )),
          Expanded(
              child: ListView.builder(
            itemCount: 3,
            padding: EdgeInsets.only(bottom: yy(10)),
            itemBuilder: (context, index) {
              return c(
                  h: yy(150),
                  color: Colors.white,
                  child: ListTile(
                    leading: const Icon(Icons.settings_input_antenna_rounded),
                    title: txtw("Antenne $index"),
                    subtitle: txtw("description"),
                    trailing: txtw('status',
                        color: index % 2 != 0 ? Colors.red : Colors.blue),
                  ));
            },
          )),
        ],
      ),
    );
  }
}
