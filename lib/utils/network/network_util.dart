import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meteo_front_end/base/base_widget.dart' as bw;

import '../constant.dart';

const String host = "http://$ip:$apiPort/";

showToast(
  String msg, {
  Color bgColor = const Color.fromRGBO(0x18, 0x23, 0x3d, 0.8),
  bool bottom = false,
  int duration = 1,
  BuildContext? contextFrom,
}) {
  var context = contextFrom ?? bw.ctxt;
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: bgColor,
      //error ? Colors.red : Theme.of(context).backgroundColor,
      behavior: SnackBarBehavior.floating,
      margin:
          EdgeInsets.only(bottom: bottom ? 100 : 400.0, right: 100, left: 100),
      content: Text(
        msg,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color:
                //error ?
                Colors.white
            //    : const Color.fromRGBO(51, 51, 51, 1),
            ),
      ),
      duration: Duration(seconds: duration),
    ),
  );
}

Dio? dio;

Future globalRequest({
  required String path,
  required Map<String, dynamic> body,
  bool isGet = false,
}) async {
  BaseOptions options = BaseOptions(
    baseUrl: host,
    contentType: "application/json",
    connectTimeout: 100000,
    receiveTimeout: 100000,
  );
  dio = Dio(options);

  Map<String, dynamic> httpBody = Map<String, dynamic>.from(body);

  log("host: $host \npath: $path \nparams: [$httpBody]");
  Map<String, dynamic> headers = ({});
  Response response;
  try {
    if (isGet) {
      response = await dio!.get(path,
          queryParameters: httpBody, options: Options(headers: headers));
    } else {
      response = await dio!
          .post(path, data: httpBody, options: Options(headers: headers));
    }
  } catch (e) {
    log("network error:$e");
    showToast("Votre connection n'est stable, veuiller réessayer plutard");
    return {};
  }
  var result = response.data;
  log("response:$result");
  return result;
}
