import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:meteo_front_end/base/base_widget.dart';
import 'package:meteo_front_end/models/models.dart';
import 'package:meteo_front_end/utils/constant.dart';
import 'package:meteo_front_end/widgets/displayInfo.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DisplayAntenna extends BaseWidget {
  List<StationData> list;
  MapController controller;
  DisplayAntenna({required this.list, required this.controller, super.key});

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _DisplayAntennaState();
  }
}

class _DisplayAntennaState extends BaseWidgetState<DisplayAntenna> {
  List<StationData> listWithTempData = [];

  init() {
    for (var d in widget.list) {
      if (!d.model!.contains("Rain")) {
        listWithTempData.add(d);
      }
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
          top: false,
          child: ListView.builder(
            itemCount: listWithTempData.length,
            padding: const EdgeInsets.only(bottom: 10),
            itemBuilder: (context, index) {
              StationData station = listWithTempData[index];
              return Listener(
                onPointerDown: (event) async {
                  Navigator.of(context).pop();
                  GeoPoint p0 = GeoPoint(
                      latitude: station.lat ?? 0, longitude: station.log ?? 0);
                  // for (var s in widget.list) {
                  //   pt(message: s.location ?? "", wtf: true);
                  //   if (s.location == station.location &&
                  //       s.model!.contains("${station.model} & Rain")) {
                  //     getWeather(id: s.serialNumber ?? "");
                  //   }
                  // }
                  await widget.controller
                      .zoomToBoundingBox(BoundingBox.fromGeoPoints([p0]));

                  await widget.controller
                      .setZoom(zoomLevel: zoomLevel)
                      .then((value) {
                    showCupertinoModalBottomSheet(
                      expand: false,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) =>
                          DisplayInfo(id: station.serialNumber ?? ""),
                    );
                  });
                },
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      color: Colors.white,
                      child: ListTile(
                        leading: const Icon(
                          Icons.settings_input_antenna_rounded,
                          size: 35,
                          color: Colors.blue,
                        ),
                        title: Text(
                          station.location ?? "",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(station.serialNumber ?? ""),
                        trailing: Text(
                          station.deviceNumber ?? "",
                          style: const TextStyle(
                              color: Colors.grey, fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              );
            },
          )),
    );
  }
}



// class DisplayAntenna extends BaseWidget {
//   const DisplayAntenna({super.key});

//   @override
//   BaseWidgetState<BaseWidget> getState() {
//     return _DisplayAntennaState();
//   }
// }

// class _DisplayAntennaState extends BaseWidgetState<DisplayAntenna> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black.withOpacity(0.7),
//       body: Column(
//         children: [
//           c(
//               h: yy(250),
//               color: Colors.white,
//               child: Stack(
//                 children: [
//                   Align(
//                     alignment: Alignment.bottomCenter,
//                     child: txtw("Liste des antennes", size: xx(70)),
//                   ),
//                   Positioned(
//                       top: yy(150),
//                       right: xx(20),
//                       child: Listener(
//                         onPointerDown: (event) => pop(),
//                         child: c(
//                             color: Colors.red,
//                             boxShape: BoxShape.circle,
//                             w: xx(80),
//                             h: yy(80),
//                             child: Icon(
//                               Icons.close,
//                               size: xx(80),
//                             )),
//                       )),
//                 ],
//               )),
//           Expanded(
//               child: 
// ListView.builder(
//             itemCount: 3,
//             padding: EdgeInsets.only(bottom: yy(10)),
//             itemBuilder: (context, index) {
//               return c(
//                   h: yy(150),
//                   color: Colors.white,
//                   child: ListTile(
//                     leading: const Icon(Icons.settings_input_antenna_rounded),
//                     title: txtw("Antenne $index"),
//                     subtitle: txtw("description"),
//                     trailing: txtw('status',
//                         color: index % 2 != 0 ? Colors.red : Colors.blue),
//                   ));
//             },
//           )),
//         ],
//       ),
//     );
//   }
// }
