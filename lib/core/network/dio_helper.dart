import 'package:dio/dio.dart';
import 'package:next_shop_app/core/constants/constants.dart';
import 'package:next_shop_app/core/exceptions/exceptions.dart';

abstract class BaseDioHelper {
  Future<dynamic> post({
    String? base,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    ProgressCallback? progressCallback,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  });

  Future<dynamic> patch({
    String? base,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    ProgressCallback? progressCallback,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  });

  Future<dynamic> get({
    String? base,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  });

  Future<dynamic> delete({
    String? base,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  });
}

class DioHelper extends BaseDioHelper {
  Dio _dio() {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: AppApis.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 50000,
        receiveTimeout: 50000,
      ),
    );

    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      error: true,
      requestHeader: true,
      responseHeader: false,
      request: true,
      responseBody: true,
    ));

    return dio;
  }

  @override
  Future<dynamic> get({
    String? base,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  }) async {
    return await request(
      call: () async => await _dio().get(
        endPoint,
        queryParameters: query,
        cancelToken: cancelToken,
        options: Options(
          headers: {
            if (isMultipart) 'Content-Type': 'multipart/form-data',
            if (!isMultipart) 'Content-Type': 'application/json',
            if (!isMultipart) 'Accept': 'application/json',
            if (token != null) 'token': token,
          },
        ),
      ),
    );
  }

  @override
  Future<dynamic> post({
    String? base,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    ProgressCallback? progressCallback,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  }) async {
    return await request(
      call: () async => await _dio().post(
        endPoint,
        data: data,
        queryParameters: query,
        onSendProgress: progressCallback,
        cancelToken: cancelToken,
        options: Options(
          headers: {
            if (isMultipart) 'Content-Type': 'multipart/form-data',
            if (!isMultipart) 'Content-Type': 'application/json',
            if (!isMultipart) 'Accept': 'application/json',
            if (token != null) 'token': token,
          },
        ),
      ),
    );
  }

  @override
  Future patch({
    String? base,
    required String endPoint,
    data,
    query,
    String? token,
    ProgressCallback? progressCallback,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  }) async {
    return await request(
      call: () async => await _dio().patch(
        endPoint,
        data: data,
        queryParameters: query,
        onSendProgress: progressCallback,
        cancelToken: cancelToken,
        options: Options(
          headers: {
            if (isMultipart) 'Content-Type': 'multipart/form-data',
            if (!isMultipart) 'Content-Type': 'application/json',
            if (!isMultipart) 'Accept': 'application/json',
            if (token != null) 'token': token,
          },
        ),
      ),
    );
  }

  @override
  Future delete({
    String? base,
    required String endPoint,
    data,
    query,
    String? token,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  }) async {
    return await request(
      call: () async => await _dio().delete(
        endPoint,
        data: data,
        queryParameters: query,
        cancelToken: cancelToken,
        options: Options(
          headers: {
            if (isMultipart) 'Content-Type': 'multipart/form-data',
            if (!isMultipart) 'Content-Type': 'application/json',
            if (!isMultipart) 'Accept': 'application/json',
            if (token != null) 'token': token,
          },
        ),
      ),
    );
  }
}

extension on BaseDioHelper {
  Future request({
    required Future<Response> Function() call,
  }) async {
    try {
      final r = await call.call();
      return r.data;
    } on DioError {
      throw PrimaryServerException(
        message: 'Hello from primary exception',
      );
    } catch (e) {
      PrimaryServerException exception = e as PrimaryServerException;

      throw PrimaryServerException(
        message: exception.message,
      );
    }
  }
}
