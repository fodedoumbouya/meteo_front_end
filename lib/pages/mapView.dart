import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:meteo_front_end/base/base_widget.dart';
import 'package:meteo_front_end/utils/constant.dart';
import 'package:meteo_front_end/widgets/displayInfo.dart';

class MapsView extends BaseWidget {
  MapController controller;
  FunctionBoolCallback onMapReady;
  MapsView({required this.controller, required this.onMapReady, super.key});

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
      onGeoPointClicked: (p0) {
        controller.zoomToBoundingBox(BoundingBox.fromGeoPoints([p0]));
        controller.setZoom(zoomLevel: zoomLevel);
        toFullScreenDialog(const DisplayInfo());
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
