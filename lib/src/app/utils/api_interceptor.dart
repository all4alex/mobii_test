import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ApiInterceptor extends Interceptor {
  Logger logger = Logger(
    filter: null, // Use the default LogFilter (-> only log in debug mode)
    printer: PrettyPrinter(), // Use the PrettyPrinter to format and print log
    output: null, // Use the default LogOutput (-> send everything to console)
  );
  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    logger.d(response.statusCode);
    logger.d(response.data);

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    return super.onError(err, handler);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    logger.d(options.uri);
    logger.d(options.data.toString());
    // dynamic token = await SecureStorage().getLoginToken();

    return super.onRequest(options, handler);
  }
}
