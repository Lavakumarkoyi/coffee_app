import 'package:coffee_app/core/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerSingleton<DioClient>(DioClient());
}
