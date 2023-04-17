import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:meteo_front_end/base/base_widget.dart';
import 'package:meteo_front_end/models/models.dart';
import 'package:meteo_front_end/pages/mapView.dart';
import 'package:meteo_front_end/widgets/displayAntenna.dart';
import 'package:meteo_front_end/widgets/weatherView/weather_animation.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
  bool isStationAdded = false;
  List<StationData> list = [];

  iniMapConfig() {
    controller = MapController(
      initMapWithUserPosition: false,
      initPosition: GeoPoint(
        latitude: 42.1709665,
        longitude: 9.2968167,
      ),
      areaLimit: BoundingBox(
          north: 43.2612, east: 11.0880, south: 41.1063, west: 7.0120),
    );
  }

  getData() {
    postMap("station", {}, (callback) {
      if (callback['code'] == 200) {
        for (var s in callback['data']) {
          list.add(StationData.fromJson(s));
        }

        rebuildState();

        if (!isStationAdded && onMapReady) {
          isStationAdded = true;
          addStations();
        }
      }
    });
  }

  @override
  void initState() {
    iniMapConfig();
    getData();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  addStations() {
    for (var station in list) {
      controller.addMarker(
        GeoPoint(latitude: station.lat ?? 0, longitude: station.log ?? 0),
        markerIcon: const MarkerIcon(
          icon: Icon(Icons.location_on),
        ),
      );
    }
    if (list.isNotEmpty) {
      isStationAdded = true;
    }

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
              if (weatherScene != WeatherScene.none) {
                weatherScene = WeatherScene.none;
                rebuildState();
              }
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
              // toFullScreenDialog(const DisplayAntenna());
              // getData();

              showCupertinoModalBottomSheet(
                expand: false,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => DisplayAntenna(
                  list: list,
                  controller: controller,
                ),
              );
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
    return Material(
      child: Scaffold(
        body: Stack(children: [
          MapsView(
            controller: controller,
            list: list,
            onMapReady: (o) {
              if (o) {
                onMapReady = o;
                addStations();
              }
            },
            onClikeStationId: (o) {
              getWeather(id: o);
            },
          ),
          // TODO Don't delete it this is weather view
          IgnorePointer(
            ignoring: true,
            child: c(
              h: sh(),
              w: sw(),
              child: weatherScene.getWeather(),
            ),
          ),

          ...myWidgets.map((e) => onMapReady ? e : sb).toList(),

          // const DisplayInfo(),
        ]),
      ),
    );
  }
}
