//by Dipak07Iml
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocboilerplat/bloc/userBloc/user.dart';
import 'package:flutterblocboilerplat/utils/constants.dart';
import 'package:flutterblocboilerplat/utils/shared_pref.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mime/mime.dart';

class Service {
  GlobalKey<NavigatorState> navigationKey;

  generateHeaders() async {
    String _token = await SharedPref.readString(AUTH_TOKEN);
    return {
      'Authorization': 'Bearer $_token',
    };
  }

  Future<Map<String, dynamic>> post(
      String _url, Map<String, String> _headers, Map<String, String> _params) {
    print('_url => $_url');
    if (_headers != null) {
      print('_headers => $_headers');
    }
    print('_params => $_params');
    return http
        .post(Uri.parse(BASE_URL + _url),
        headers: (_headers != null) ? _headers : {}, body: _params)
        .then(
          (response) {
        final code = response.statusCode;
        final body = response.body;
        final jsonBody = json.decode(body);
        print('response code => $code');
        print('response body => $body');

        Map<String, dynamic> _resDic;
        if (code == 200 || code == 300) {
          _resDic = Map<String, dynamic>.from(jsonBody);
          _resDic[HTTP_CODE] = code;
          print('Success => ${_resDic[HTTP_CODE]}');
          if (code == 422) {
            SharedPref.saveString(AUTH_TOKEN, '');
            SharedPref.saveInt(USER_TYPE, 0);
            SharedPref.saveObject(USER, null);
            SharedPref.resetData();
            navigationKey.currentState
                .pushNamedAndRemoveUntil(LOGIN, (route) => false);

            if (_resDic[IS_TOKEN_EXPIRED] == 1) {
              _resDic[HTTP_CODE] = 422;
            }
          }
        } else {
          _resDic = Map<String, dynamic>();
          _resDic[HTTP_CODE] = code;
          _resDic[IS_TOKEN_EXPIRED] = 0;
          _resDic[MESSAGE] = jsonBody[MESSAGE] != null
              ? jsonBody[MESSAGE]
              : 'Something went wrong';
          _resDic[HTTP_CODE] = code;
          _resDic[HTTP_CODE] = Map<String, dynamic>.from(jsonBody);
        }
        print('===>> Response : $_resDic');
        return _resDic;
      },
    );
  }

  Future<Map<String, dynamic>> get(String _url, Map<String, String> _headers) {
    print('_url => $_url');
    if (_headers != null) {
      print('_headers => $_headers');
    }
    return http
        .get(Uri.parse(BASE_URL + _url),
        headers: (_headers != null) ? _headers : {})
        .then(
          (response) {
        try {
          final code = response.statusCode;
          final body = response.body;
          print('response code => ${response.body}');
          final jsonBody = json.decode(body);
          Map<String, dynamic> _resDic;
          if (code == 200) {
            _resDic = Map<String, dynamic>.from(jsonBody);
            _resDic[HTTP_CODE] = code;
            if (code == 422) {
              BlocBuilder<UserBloc, UserState>(builder: (ctx, state) {
                SharedPref.saveString(AUTH_TOKEN, '');
                SharedPref.saveInt(USER_TYPE, 0);
                SharedPref.saveObject(USER, null);
                SharedPref.resetData();
                showColoredSnakeBar(
                    color: Colors.red,
                    con: ctx,
                    msg: "Your Session is Expired");
                //showSnakeBar(ctx, "Your Session is Expired");
                Navigator.pushNamedAndRemoveUntil(ctx, LOGIN, (route) => false);
              });
            }
          } else {
            _resDic = Map<String, dynamic>();
            _resDic[STATUS] = false;
            _resDic[IS_TOKEN_EXPIRED] = 0;
            _resDic[MESSAGE] = jsonBody[MESSAGE] != null
                ? jsonBody[MESSAGE]
                : 'Something went wrong';
            _resDic[HTTP_CODE] = code;
          }
          print('===>> Response : $_resDic');
          return _resDic;
        } catch (err) {
          BlocBuilder<UserBloc, UserState>(builder: (ctx, state) {
            SharedPref.saveString(AUTH_TOKEN, '');
            SharedPref.saveInt(USER_TYPE, 0);
            SharedPref.saveObject(USER, null);
            SharedPref.resetData();
            showColoredSnakeBar(
                color: Colors.red, con: ctx, msg: "Your Session is Expired");
            // showSnakeBar(ctx, "Your Session is Expired");
            Navigator.pushNamedAndRemoveUntil(ctx, LOGIN, (route) => false);
          });
        }
      },
    );
  }

  Future<Map<String, dynamic>> multipartPost(
      String _url,
      Map<String, String> _headers,
      Map<String, dynamic> _params,
      ) async {
    if (_headers != null) {
      print('_headers => $_headers');
    }
    print('_params => $_params');

    print('_url => $_url');
    var request = http.MultipartRequest("POST", Uri.parse(BASE_URL + _url));
    if (_headers != null) {
      request.headers.addAll(_headers);
    }
    if (_params != null) {
      _params.forEach((key, value) {
        if (value is String) {
          request.fields.putIfAbsent(key, () => value);
        } else if (value is List) {
          request.fields.putIfAbsent(key, () => '[${value.join(',')}]');
        }
      });
    }

    var response = await request.send();
    final code = response.statusCode;
    print('response code => $code');
    final responseBody = await http.Response.fromStream(response);
    final body = responseBody.body;
    print('response ==> $body');
    final jsonBody = json.decode(body);

    print('response body => $jsonBody');
    Map<String, dynamic> _resDic;
    if (code == 200) {
      _resDic = Map<String, dynamic>.from(jsonBody);
      _resDic[STATUS] = _resDic[SUCCESS] == 1;
    } else {
      _resDic = Map<String, dynamic>();
      _resDic[STATUS] = false;
      _resDic[IS_TOKEN_EXPIRED] = 0;
      _resDic[MESSAGE] = jsonBody[MESSAGE] != null
          ? jsonBody[MESSAGE]
          : 'Something went wrong';
    }
    _resDic[HTTP_CODE] = code;
    print('===>> Response : $_resDic');
    return _resDic;
  }

  Future<Map<String, dynamic>> postWithImage(
      String _url,
      Map<String, String> _headers,
      Map<String, String> _params,
      String _imageKey,
      File _imageFile) async {
    if (_headers != null) {
      print('_headers => $_headers');
    }
    print('_params => $_params');

    print('_url => $_url');
    var request = http.MultipartRequest("POST", Uri.parse(BASE_URL + _url));
    if (_headers != null) {
      request.headers.addAll(_headers);
    }
    if (_params != null) {
      request.fields.addAll(_params);
    }
    if (_imageFile != null) {
      final _type = lookupMimeType(_imageFile.path);
      final _name =
          '${DateTime.now().toIso8601String()}.${_type.split('/').last}';

      final _partFile = http.MultipartFile(_imageKey,
          _imageFile.readAsBytes().asStream(), _imageFile.lengthSync(),
          filename: _name);
      request.files.add(_partFile);

      print('request files: ${request.files}');
    }
    var response = await request.send();
    final code = response.statusCode;
    print('response code => $code');
    final responseBody = await http.Response.fromStream(response);
    final body = responseBody.body;
    print('response ==> $body');
    final jsonBody = json.decode(body);

    print('response body => $jsonBody');
    Map<String, dynamic> _resDic;
    if (code == 200) {
      _resDic = Map<String, dynamic>.from(jsonBody);
      _resDic[STATUS] = _resDic[SUCCESS] == 1;
    } else {
      _resDic = Map<String, dynamic>();
      _resDic[STATUS] = false;
      _resDic[IS_TOKEN_EXPIRED] = 0;
      _resDic[MESSAGE] = jsonBody[MESSAGE] != null
          ? jsonBody[MESSAGE]
          : 'Something went wrong';
    }
    _resDic[HTTP_CODE] = code;
    print('===>> Response : $_resDic');
    return _resDic;
  }
}

Future<Map<String, dynamic>> delete(String _url, Map<String, String> _headers) {
  print('_url => $_url');
  if (_headers != null) {
    print('_headers => $_headers');
  }
  return http
      .delete(Uri.parse(BASE_URL + _url),
      headers: (_headers != null) ? _headers : {})
      .then(
        (response) {
      final code = response.statusCode;
      final body = response.body;
      final jsonBody = json.decode(body);
      print('response code => $code');
      print('response body => $body');
      Map<String, dynamic> _resDic;
      if (code == 200) {
        _resDic = Map<String, dynamic>.from(jsonBody);
        _resDic[STATUS] = _resDic[SUCCESS] == 1;
        if (!_resDic[STATUS]) {
          if (_resDic[IS_TOKEN_EXPIRED] == 1) {
            _resDic[HTTP_CODE] = 401;
          }
        }
      } else {
        _resDic = Map<String, dynamic>();
        _resDic[STATUS] = false;
        _resDic[IS_TOKEN_EXPIRED] = 0;
        _resDic[MESSAGE] = jsonBody[MESSAGE] != null
            ? jsonBody[MESSAGE]
            : 'Something went wrong';
        _resDic[HTTP_CODE] = code;
      }
      print('===>> Response : $_resDic');
      return _resDic;
    },
  );
}
