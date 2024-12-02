// ignore_for_file: dead_code

import 'dart:convert';
import 'dart:developer' as logging;

import 'package:flutter/foundation.dart';
import 'package:flutter_app/constants/variables.dart';

import 'package:http/http.dart' as http;

getHeader() async {
  // printStatement(EnvironmentConfig.getBaseUrl(getCurrentEnvironment()));
  var headers = {
    'api-key': apiKey,
  };

  return headers;
}

// post(String url, Map data,
//     {bool token = false, bool withoutBody = false}) async {
//   printUrlAndHeaderAndBody(
//       url: baseUrl + url,
//       body: data,
//       header: await getHeader(token),
//       method: "post");
//   final res = !withoutBody
//       ? await http.post(Uri.parse(baseUrl + url),
//           body: json.encode(data), headers: await getHeader(token))
//       : await http.post(Uri.parse(baseUrl + url),
//           headers: await getHeader(token));
//   if (kDebugMode) {
//     debugPrint('Response Body: ${res.body}');
//   }

//   CommonRestBody body = app.responseMessage(res.body);
//   if (body.error?.status ==
//           HttpCodeEnum.refreshTokenRequired.status.toString() ||
//       res.statusCode == HttpCodeEnum.unauthorized.status) {
//     if (customerProvider.isAuthorized) {
//       final value = await refreshToken();
//       if (value != null) {
//         return !withoutBody
//             ? await http.post(Uri.parse(baseUrl + url),
//                 body: json.encode(data), headers: await getHeader(token))
//             : await http.post(Uri.parse(baseUrl + url),
//                 headers: await getHeader(token));
//       }
//     }
//   } else {
//     return res;
//   }
// }

get(String url, {String? tokenHeader, bool token = false}) async {
  printUrlAndHeaderAndBody(
      url: baseUrl + url, body: {}, header: await getHeader(), method: "get");
  final response =
      await http.get(Uri.parse(baseUrl + url), headers: await getHeader());
  if (response.statusCode == HttpCodeEnum.Ok.status ||
      response.statusCode == HttpCodeEnum.Created.status ||
      response.statusCode == HttpCodeEnum.Accepted.status) {
    printStatement(response.statusCode);
    return response.body;
  }
}

// put(String url, Map data,
//     {bool token = false, bool withoutBody = false}) async {
//   printUrlAndHeaderAndBody(
//       url: baseUrl + url,
//       body: data,
//       header: await getHeader(token),
//       method: "put");
//   final res = !withoutBody
//       ? await http.put(Uri.parse(baseUrl + url),
//           body: json.encode(data), headers: await getHeader(token))
//       : await http.put(Uri.parse(baseUrl + url),
//           headers: await getHeader(token));
//   if (!token) {
//     return res;
//   } else {
//     CommonRestBody body = app.responseMessage(res.body);
//     if (body.error?.status ==
//             HttpCodeEnum.refreshTokenRequired.status.toString() ||
//         res.statusCode == HttpCodeEnum.unauthorized.status) {
//       if (customerProvider.isAuthorized) {
//         final value = await refreshToken();
//         if (value != null) {
//           return await http.put(Uri.parse(baseUrl + url),
//               body: json.encode(data), headers: await getHeader(token));
//         }
//       }
//     } else {
//       return res;
//     }
//   }
// }
// delete(String url, {bool token = false}) async {
//   printUrlAndHeaderAndBody(
//       url: baseUrl + url,
//       body: {},
//       header: await getHeader(token),
//       method: "delete");
//   final res = await http.delete(Uri.parse(baseUrl + url),
//       headers: await getHeader(token));
//   if (!token) {
//     return res;
//   } else {
//     CommonRestBody body = app_.responseMessage(res);
//     if (body.error?.status ==
//             HttpCodeEnum.refreshTokenRequired.status.toString() ||
//         res.statusCode == HttpCodeEnum.unauthorized.status) {
//       if (customerProvider.isAuthorized) {
//         final value = await refreshToken();
//         if (value != null) {
//           return await http.delete(Uri.parse(baseUrl + url),
//               headers: await getHeader(token));
//         }
//       }
//     } else {
//       return res;
//     }
//   }
// }

// patch(String url, {bool token = false}) async {
//   printUrlAndHeaderAndBody(
//       url: baseUrl + url, body: {}, header: await getHeader(token));
//   final res = await http.patch(Uri.parse(baseUrl + url),
//       headers: await getHeader(token));
//   if (!token) {
//     return res;
//   } else {
//     CommonRestBody body = app_.responseMessage(res);
//     if (body.error?.status ==
//             HttpCodeEnum.refreshTokenRequired.status.toString() ||
//         res.statusCode == HttpCodeEnum.unauthorized.status) {
//       if (customerProvider.isAuthorized) {
//         final value = await refreshToken();
//         if (value != null) {
//           return await http.patch(Uri.parse(baseUrl + url),
//               headers: await getHeader(token));
//         }
//       }
//     } else {
//       return res;
//     }
//   }
// }

// putWithoutBody(String url, {bool token = false}) async {
//   printUrlAndHeaderAndBody(
//       url: baseUrl + url,
//       body: {},
//       header: await getHeader(token),
//       method: "put");
//   final res =
//       await http.put(Uri.parse(baseUrl + url), headers: await getHeader(token));
//   if (!token) {
//     return res;
//   } else {
//     CommonRestBody body = app_.responseMessage(res);
//     if (body.error?.status ==
//             HttpCodeEnum.refreshTokenRequired.status.toString() ||
//         res.statusCode == HttpCodeEnum.unauthorized.status) {
//       if (customerProvider.isAuthorized) {
//         final value = await refreshToken();
//         if (value != null) {
//           return await http.put(Uri.parse(baseUrl + url),
//               headers: await getHeader(token));
//         }
//       }
//     } else {
//       return res;
//     }
//   }
// }

// Future<AuthModel?> refreshToken({bool token = false}) async {
//   AuthModel refreshTokenModel = AuthModel(
//     token: await app.getToken(),
//   );
//   printUrlAndHeaderAndBody(
//       url: "$baseUrl$authenticationApi/refresh-token",
//       body: refreshTokenModel.toJson(),
//       header: {},
//       method: "post");
//   final resRefreshToken = await http.post(
//     Uri.parse("$baseUrl$authenticationApi/refresh-token"),
//     body: json.encode(refreshTokenModel.toJson()),
//     headers: {
//       'Content-Type': 'application/json',
//       'Accept': '*/*',
//       'Authorization': 'Bearer ${refreshTokenModel.token ?? ""}'
//     },
//   );
//   CommonRestBody body = app.responseMessage(resRefreshToken);
//   if (!(body.status ?? true)) {
//     AuthModel tokenModel = AuthModel.fromJson(body.data);
//     await storeToken(tokenModel.token ?? "");
//     await app.setTokenRefreshedTime();
//     debugPrint(
//         "############################## Refreshed Token #####################################");
//     debugPrint(tokenModel.token.toString());
//     debugPrint(
//         "############################## Refreshed Token #####################################");
//     return tokenModel;
//   } else {
//     return null;
//   }
// }

// postFiles(String url, {required List<File> files, bool token = false}) async {
//   printUrlAndHeaderAndBody(
//       url: baseUrl + url, body: "", header: "", method: "post");
//   final postUrlWithImage =
//       http.MultipartRequest('POST', Uri.parse(baseUrl + url));
//   if (token) {
//     postUrlWithImage.headers.addAll({'token': await app.getToken()});
//   }
//   // for (var file in files) {
//   //   postUrlWithImage.files.add(
//   //     await http.MultipartFile.fromPath(
//   //       'image', // This is the key that the server expects
//   //       file.path,
//   //       filename: 'uploaded_image.jpg',
//   //       contentType: MediaType('image', 'png'),
//   //     ),
//   //   );
//   // }
//   for (var file in files) {
//     postUrlWithImage.files.add(
//       http.MultipartFile.fromBytes(
//         'image',
//         file.readAsBytesSync(),
//         filename: file.path.split("/").last,
//         contentType: MediaType('image', 'jpg'),
//       ),
//     );
//   }

//   var response = await postUrlWithImage.send();
//   // print('Response Status Code: ${response.statusCode}');
//   // print('Response Status Code: ${await response.stream.bytesToString()}');

//   if (response.statusCode == HttpCodeEnum.ok.status) {
//     return response;
//   } else if (response.statusCode == HttpCodeEnum.unauthorized.status) {
//     if (customerProvider.isAuthorized) {
//       final value = await refreshToken();
//       if (value != null) {
//         return await postUrlWithImage.send();
//       }
//     }
//   } else {
//     return null;
//   }
// }

// getForUrl(String url, {token = false}) async {
//   return http.get(Uri.parse(url), headers: await getHeader(token));
// }

// storeToken(String token) async {
//   app.setToken(token ?? "");
//   //app_.setRefreshToken(tokenModel.refreshToken ?? "");
// }

// storeAddress(AuthModel tokenModel) async {
//   app.setToken(tokenModel.token ?? "");
// }

//debugPrint the data and help to copy the data
printUrlAndHeaderAndBody(
    {String? url, dynamic body, dynamic header, method}) async {
  if (kDebugMode) {
    debugPrint("----------------------------------------");
    logging.log(url ?? "");
    debugPrint(url);
    logging.log(jsonEncode(body));
    // debugPrint(header);
    logging.log(header.toString());
    debugPrint("----------------------------------------");
  }
}

//Print Statement for Debugging
printStatement(dynamic status) {
  if (kDebugMode) {
    debugPrint("----------------------------------------");
    print(status);
    debugPrint("----------------------------------------");
  }
}

enum HttpCodeEnum {
  Ok,
  Created,
  Accepted,
  BadRequest,
  Unauthorized,
  Forbidden,
  NotFound,
  RequestTimeout,
  InternalServerError,
  RefereshTokenReguired
}

extension HttpCodeEnumExtenstion on HttpCodeEnum {
  int get status {
    switch (this) {
      case HttpCodeEnum.Ok:
        return 200;
      case HttpCodeEnum.Created:
        return 201;
      case HttpCodeEnum.Accepted:
        return 202;
      case HttpCodeEnum.BadRequest:
        return 400;
      case HttpCodeEnum.Unauthorized:
        return 401;
      case HttpCodeEnum.Forbidden:
        return 403;
      case HttpCodeEnum.NotFound:
        return 404;
      case HttpCodeEnum.RequestTimeout:
        return 408;
      case HttpCodeEnum.InternalServerError:
        return 500;
      case HttpCodeEnum.RefereshTokenReguired:
        return 410;
      default:
        return 400;
    }
  }
}
