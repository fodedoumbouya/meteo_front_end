import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:meteo_front_end/base/base_widget.dart';
import 'package:meteo_front_end/pages/mapView.dart';
import 'package:meteo_front_end/widgets/displayAntenna.dart';

import '../widgets/weatherView/src/model/scenes.dart';

class Home extends BaseWidget {
  const Home({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _HomeState();
  }
}

class _HomeState extends BaseWidgetState<Home> {
  late MapController controller;
  bool onMapReady = false;
  @override
  void initState() {
    controller = MapController(
      initMapWithUserPosition: false,
      initPosition: GeoPoint(
        latitude: 42.1709665,
        longitude: 9.2968167,
      ),
      areaLimit: BoundingBox(
          north: 43.2612, east: 11.0880, south: 41.1063, west: 7.0120),
    );

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  addMarks() {
    controller.addMarker(
      GeoPoint(latitude: 42.2736386, longitude: 8.9989234),
      markerIcon: const MarkerIcon(
        icon: Icon(Icons.location_on),
      ),
    );

    rebuildState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> myWidgets = [
      Positioned(
          right: xx(50),
          bottom: yy(200),
          child: Listener(
            onPointerDown: (event) {
              controller.zoomIn();
            },
            child: c(
              h: yy(150),
              w: xx(150),
              boxShape: BoxShape.circle,
              color: Colors.black.withOpacity(0.5),
              child: Icon(
                Icons.add,
                size: xx(100),
              ),
            ),
          )),
      Positioned(
          right: xx(50),
          bottom: yy(50),
          child: Listener(
            onPointerDown: (event) {
              controller.zoomOut();
              // await controller.enableTracking(enableStopFollow: true);
            },
            child: c(
              h: yy(150),
              w: xx(150),
              boxShape: BoxShape.circle,
              color: Colors.black.withOpacity(0.5),
              child: Icon(
                Icons.remove,
                size: xx(100),
              ),
            ),
          )),
      Positioned(
          right: xx(50),
          bottom: yy(400),
          child: Listener(
            onPointerDown: (event) async {
              await controller.zoomToBoundingBox(BoundingBox(
                  north: 43.2612, east: 11.0880, south: 41.1063, west: 7.0120));
              controller.zoomIn();
            },
            child: c(
              h: yy(150),
              w: xx(150),
              boxShape: BoxShape.circle,
              color: Colors.black.withOpacity(0.5),
              child: Icon(
                Icons.location_on_outlined, // settings_input_antenna
                size: xx(100),
              ),
            ),
          )),
      Positioned(
          left: xx(50),
          top: yy(100),
          child: Listener(
            onPointerDown: (event) {
              toFullScreenDialog(const DisplayAntenna());
            },
            child: c(
              h: yy(150),
              w: xx(150),
              boxShape: BoxShape.circle,
              color: Colors.black.withOpacity(0.5),
              child: Icon(
                Icons.settings_input_antenna,
                size: xx(100),
              ),
            ),
          )),
    ];
    return Scaffold(
      body: Stack(children: [
        MapsView(
          controller: controller,
          onMapReady: (o) {
            if (o) {
              onMapReady = o;
              addMarks();
            }
          },
        ),
        // TODO Don't delete it this is weather view
        IgnorePointer(
          ignoring: true,
          child: c(
            h: sh(),
            w: sw(),
            child: WeatherScene.sunset.getWeather(),
          ),
        ),

        ...myWidgets.map((e) => onMapReady ? e : sb).toList(),

        // const DisplayInfo(),
      ]),
    );
  }
}
