import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

late Dio _appDio;

Dio getAppDio() => _appDio;

void setAppDio(Dio dio) => _appDio = dio;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
