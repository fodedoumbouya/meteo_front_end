import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meteo_front_end/models/models.dart';
import 'package:meteo_front_end/utils/myLog.dart';
import 'package:meteo_front_end/utils/network/network_util.dart';
import 'package:meteo_front_end/widgets/weatherView/weather_animation.dart';

typedef FunctionBoolCallback = void Function(bool o);
typedef FunctionStringCallback = void Function(String o);

var ctxt;

abstract class BaseWidget extends StatefulWidget {
  const BaseWidget({Key? key}) : super(key: key);

  @override
  BaseWidgetState createState() {
    return getState();
  }

  BaseWidgetState getState();
}

abstract class BaseWidgetState<T extends BaseWidget> extends State<T>
    with WidgetsBindingObserver {
  WeatherScene weatherScene = WeatherScene.none;

  @override
  void initState() {
    ctxt = context;
    pt(message: "main initState");
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
    } else if (state == AppLifecycleState.paused) {}
  }

  @override
  void didChangeDependencies() {
    pt(message: "didChangeDependencies\n");

    super.didChangeDependencies();
  }

  getWeather({
    required String id,
  }) async {
    var response =
        await postMap("weather/measurements?id=$id", {}, (callback) {});
    Map<String, dynamic> json = jsonDecode(response);
    RequestResp requestResp = RequestResp.fromJson(json);
    if (requestResp.code == 200) {
      weatherScene = getWeatherByName(name: requestResp.data ?? "");
      rebuildState();
    }
  }

  Future toFullScreenDialog(Widget w) {
    pt(
        message:
            "Displaying dialog =======================>${w.toStringShallow()}");

    return Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        fullscreenDialog: true,
        settings: RouteSettings(name: "/${w.toStringShallow()}"),
        pageBuilder: (BuildContext context, _, __) => w));
  }

  Future toPage(Widget w) {
    pt(message: "Move to Page=======================>${w.toStringShallow()}");
    // return Navigator.of(context).push(MaterialPageRoute(builder: (con) {
    //   return w;
    // }));
    return Navigator.of(context).push(
      MaterialPageRoute(
        settings: RouteSettings(name: "/${w.toStringShallow()}"),
        builder: (context) => w,
      ),
    );
  }

  void popUntil(String name) {
    pt(message: "pop until  Page=======================>$name");
    Navigator.of(context).popUntil(ModalRoute.withName("/$name"));
  }

  void jumpToPagePop(Widget w) {
    backHome();
    toPage(w);
  }

  Future jumpToPage(Widget w) {
    pt(message: "Jump to Page=======================>${w.toStringShallow()}");

    // Navigator.of(context).popUntil((route) => false)

    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        settings: RouteSettings(name: "/${w.toStringShallow()}"),
        builder: (context) => w,
      ),
    );

    // pushReplacement(MaterialPageRoute(builder: (con) {
    //   return w;
    // }));
  }

  void backHome() {
    Navigator.popUntil(context, (Route route) {
      return !route.navigator!.canPop();
    });
  }

  void jumpCleanToPage(Widget w) {
    backHome();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (con) {
      return w;
    }));
  }

  Color bc() {
    return Theme.of(context).colorScheme.background;
  }

  bp() {
    return Theme.of(context).primaryColorLight;
  }

  bcB() {
    return Theme.of(context).primaryColorDark;
  }

  dv({Color color = Colors.black45}) {
    return Divider(
      color: color,
    );
  }

  Widget get sb => const SizedBox();

  txtw(String t,
      {Color? color,
      FontWeight? fontWeight,
      double? size,
      bool withOverflow = true}) {
    // color ??= const Color.fromRGBO(0, 0, 0, 0.392);
    TextOverflow? overflow = withOverflow ? TextOverflow.ellipsis : null;
    return Text(
      t,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: size,
        overflow: overflow,
      ),
    );
  }

  pt(
      {required Object message,
      bool e = false,
      bool w = false,
      bool wtf = false,
      bool d = false,
      bool v = false}) {
    String msg = (w || e)
        ? "\n-----------------------------------------------------------------------\n\n$message \n-----------------------------------------------------------------------\n\n"
        : message.toString();
    if (e) {
      AppLog.e(msg);
    } else if (w) {
      AppLog.w(msg);
    } else if (wtf) {
      AppLog.wtf(msg);
    } else if (d) {
      AppLog.d(msg);
    } else if (v) {
      AppLog.v(msg);
    } else {
      AppLog.i(msg);
    }
  }

  void pop([Object? o]) {
    Navigator.of(context).pop(o);
  }

  double xx(double x) {
    return sw() / 1080.0 * x;
  }

  double yy(double y) {
    return sh() / 2220 * y;
  }

  rebuildState() {
    if (mounted) {
      //|| !isDispose
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    pt(message: "build\n");

    // onCreate();
    // ctxt = context;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: baseBuild(context),
    );
  }

  double sw() {
    return MediaQuery.of(context).size.width;
  }

  double sh() {
    return MediaQuery.of(context).size.height;
  }

  baseBuild(BuildContext context) {}

  Widget c(
          {Widget? child,
          double? h,
          double? w,
          double? allM,
          double allP = 0,
          double topM = 0,
          double bottomM = 0,
          double leftM = 0,
          double rightM = 0,
          double radius = 0,
          Alignment? alig,
          Color? color,
          // String? path,
          ImageProvider<Object>? image,
          BoxFit? fit = BoxFit.fill,
          Alignment decoAlignment = Alignment.topCenter,
          String imgType = "png",
          // Color c = Colors.transparent,
          List<BoxShadow>? boxShadow,
          BoxShape boxShape = BoxShape.rectangle,
          BorderRadius? borderRadius,
          BoxBorder? border,
          Rect? centerSlice}) =>
      Container(
        alignment: alig,
        margin: allM == null
            ? EdgeInsets.only(
                left: leftM, right: rightM, bottom: bottomM, top: topM)
            : EdgeInsets.all(allM),
        padding: EdgeInsets.all(allP),
        decoration: BoxDecoration(
          color: color,
          shape: boxShape,
          boxShadow: boxShadow,
          image: image == null
              ? null
              : DecorationImage(
                  image: image,
                  colorFilter: ColorFilter.mode(
                      color ?? Colors.transparent, BlendMode.colorBurn),
                  //  Image.file(
                  //   File(path),
                  //   color: Colors.black,
                  //   colorBlendMode: BlendMode.clear,
                  // ).image,
                  //AssetImage('images/' + image + '.$imgType'),
                  scale: MediaQuery.of(context).devicePixelRatio,
                  centerSlice: centerSlice,
                  fit: fit,
                  alignment: decoAlignment),
          border: border,
          borderRadius: boxShape != BoxShape.rectangle
              ? null
              : borderRadius ?? BorderRadius.circular(radius),
        ),
        height: h,
        width: w,
        child: child,
      );

  postMap(
    String url,
    Map<String, dynamic> body,
    var callback,
  ) async {
    var res = await globalRequest(
      path: url,
      body: body,
    );
    callback(res);
    return res;
  }
}
