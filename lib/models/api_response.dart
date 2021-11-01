import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class ApiResponse extends Equatable {
  final bool isSuccessful;
  final dynamic data;
  final String msg;
  final String? errorMsg;

  ApiResponse(
      {required this.isSuccessful,
      required this.data,
      required this.msg,
      this.errorMsg});

  ApiResponse.empty()
      : isSuccessful = false,
        errorMsg = "",
        data = null,
        msg = "";

  ApiResponse.from(Map<String, dynamic> response)
      : data = response.containsKey("data") ? response["data"] : null,
        isSuccessful =
            response.containsKey("status") ? response["status"] : false,
        errorMsg = response.containsKey("error")
            ? ApiResponse.getErrorMsg(response["error"]["name"])
            : null,
        msg = response.containsKey("message") ? response["message"] : "";

  ApiResponse modifyErrorMsg(String message) => ApiResponse(
      data: this.data,
      isSuccessful: this.isSuccessful,
      msg: this.msg,
      errorMsg: "${this.errorMsg}  $message");

  static String getErrorMsg(List<dynamic> responsePart) {
    StringBuffer msg = StringBuffer();
    responsePart.forEach((message) {
      msg.write("$message ");
    });
    return msg.toString();
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [isSuccessful, errorMsg, data, msg];
}

extension ApiError on DioError {
  ApiResponse toApiError() {
    ApiResponse apiResponse = ApiResponse.empty();
    switch (this.type) {
      case DioErrorType.connectTimeout:
        return ApiResponse(
            isSuccessful: false,
            data: null,
            msg: "Timeout Error",
            errorMsg:
                "${_ErrorMessage.connectionTimeout}\n${this.error.toString()}");

      case DioErrorType.receiveTimeout:
        return ApiResponse(
            isSuccessful: false,
            data: null,
            msg: "Timeout Error",
            errorMsg:
                "${_ErrorMessage.receiveTimeout}\n${this.error.toString()}");

      case DioErrorType.sendTimeout:
        return ApiResponse(
            isSuccessful: false,
            data: null,
            msg: "Timeout Error",
            errorMsg: "${_ErrorMessage.sendTimeout}\n${this.error.toString()}");

      case DioErrorType.other:
        return ApiResponse(
            isSuccessful: false,
            data: null,
            errorMsg:
                "please help report this our support system\n ${this.toString()}",
            msg: "App Error: ");

      case DioErrorType.response:
        apiResponse = ApiResponse.from(this.response!.data);
        if (this.response!.statusCode! >= 300 &&
            this.response!.statusCode! <= 399)
          apiResponse = apiResponse.modifyErrorMsg(
              "${_ErrorMessage.unsupportedRedirect}\n${this.error.toString()}");
        if (this.response!.statusCode! == 422) {
          break;
        }
        if (this.response!.statusCode! >= 400 &&
            this.response!.statusCode! <= 499)
          apiResponse = apiResponse.modifyErrorMsg(
              _ErrorMessage.unauthorizedAccess +
                  "\n" +
                  (this.response!.statusMessage ??
                      "" + "\n" + this.error.toString()));
        if (this.response!.statusCode! >= 500 &&
            this.response!.statusCode! <= 599)
          apiResponse = apiResponse.modifyErrorMsg(
              "${_ErrorMessage.serverError}\n${this.error.toString()}");
        break;
      default:
        apiResponse = this.response != null
            ? ApiResponse.from(response!.data)
            : ApiResponse(
                isSuccessful: false,
                data: null,
                msg: "Unknown Error",
                errorMsg: this.error.toString());
        break;
    }
    return apiResponse;
  }
}

class _ErrorMessage {
  static const String connectionTimeout =
      "connection timeout: unable to contact server\n please check that your internet connection is active";
  static const String receiveTimeout =
      "error encountered while receiving server response. please check that your internet connection is not too slow";

  static const String sendTimeout =
      "error encountered while receiving server response. please check that your internet connection is not too slow";

  static const String unauthorizedAccess =
      "you are not authorized to access this functionality. please contact PayBuyMax support";

  static const String serverError =
      "internal server error\n we are working to rectify this as soon as possible or send an email to PayBuyMax support";

  static const String unsupportedRedirect = "supported redirect response";
}
