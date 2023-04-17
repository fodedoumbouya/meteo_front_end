import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:meteo_front_end/base/base_widget.dart';
import 'package:meteo_front_end/models/models.dart';
import 'package:meteo_front_end/utils/constant.dart';
import 'package:meteo_front_end/widgets/displayInfo.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MapsView extends BaseWidget {
  MapController controller;
  FunctionBoolCallback onMapReady;
  FunctionStringCallback onClikeStationId;
  List<StationData> list;
  MapsView(
      {required this.controller,
      required this.onMapReady,
      required this.list,
      required this.onClikeStationId,
      super.key});

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _MapsViewState();
  }
}

class _MapsViewState extends BaseWidgetState<MapsView> {
  late MapController controller;

  @override
  void initState() {
    controller = widget.controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OSMFlutter(
      controller: controller,
      onGeoPointClicked: (p0) async {
        StationData station = widget.list.firstWhere((element) =>
            GeoPoint(latitude: element.lat ?? 0, longitude: element.log ?? 0) ==
            p0);

        for (var s in widget.list) {
          // pt(message: s.model ?? "", wtf: true);
          if (s.location == station.location &&
              s.model!.contains("${station.model} & Rain")) {
            // pt(message: s.model ?? "", wtf: true);
            widget.onClikeStationId(s.serialNumber ?? "");
          }
        }

        await controller.zoomToBoundingBox(BoundingBox.fromGeoPoints([p0]));

        await controller.setZoom(zoomLevel: zoomLevel).then((value) {
          showCupertinoModalBottomSheet(
            expand: false,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => DisplayInfo(id: station.serialNumber ?? ""),
          );
        });
        // toFullScreenDialog(const DisplayInfo());
      },
      onLocationChanged: (p0) {
        pt(message: p0.toString(), wtf: true);
      },
      onMapIsReady: (p0) => widget.onMapReady(p0),
      // trackMyPosition: true,
      // userLocationMarker: UserLocationMaker(
      //     personMarker: const MarkerIcon(
      //       icon: Icon(Icons.circle),
      //     ),
      //     directionArrowMarker: const MarkerIcon(
      //       icon: Icon(Icons.arrow_back_ios_new),
      //     )),
      mapIsLoading: const Center(child: CircularProgressIndicator()),
      // showContributorBadgeForOSM: true,
      // showZoomController: true,
      // trackMyPosition: true,
      initZoom: 8.0,
    );
  }
}
