//by Dipak07Iml
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterblocboilerplat/services/service.dart';

abstract class UserRepository {
  Future<dynamic> login(
      String email, String password, String type, String device_token);
  Future<dynamic> updateProfile(Map<String, dynamic> params);
  Future<dynamic> addcompany(Map<String, String> params);
  Future<dynamic> forgotpassword(Map<String, String> params);
  Future<dynamic> updatecompany(Map<String, String> params);
  Future<dynamic> getcompany();
  Future<dynamic> adddesign(Map<String, dynamic> params);
  Future<dynamic> getdesign();
  Future<dynamic> getdesigndetail(String name);
  Future<dynamic> addSize(Map<String, String> params);
  Future<dynamic> getSize(String company_id);
  Future<dynamic> getType();
  Future<dynamic> addretailer(Map<String, dynamic> params);
  Future<dynamic> editretailer(Map<String, dynamic> params);
  Future<dynamic> addwholselerparchaseorder(Map<String, String> params);
  Future<dynamic> addwholselersellesorder(Map<String, String> params);
  Future<dynamic> changePassword(Map<String, String> params);

  Future<dynamic> getretailer();
}

class UserRepositoryImpl implements UserRepository {
  final Service _service = Service();

  @override
  Future<dynamic> login(
      String email, String password, String type, String device_token) async {
    return _service.post('login', null, {
      'email': email,
      'password': password,
      'type': type,
      'device_type': Platform.isAndroid ? 'android' : 'ios',
      'device_token': device_token
    });
  }

  @override
  Future changePassword(Map<String, String> params) async {
    final _header = await _service.generateHeaders() as Map<String, String>;
    return _service.post('change/password', _header, params);
  }

  @override
  Future addcompany(Map<String, String> params) async {
    final _header = await _service.generateHeaders() as Map<String, String>;
    return _service.post('company/add', _header, params);
  }

  @override
  Future forgotpassword(Map<String, String> params) async {
    final _header = await _service.generateHeaders() as Map<String, String>;
    return _service.post('forgot/password', _header, params);
  }

  @override
  Future getcompany() async {
    final _header = await _service.generateHeaders() as Map<String, String>;
    return _service.get('companies', _header);
  }

  @override
  Future addSize(Map<String, String> params) async {
    final _header = await _service.generateHeaders() as Map<String, String>;
    return _service.post('size/add', _header, params);
  }

  @override
  Future addwholselersellesorder(Map<String, String> params) async {
    final _header = await _service.generateHeaders() as Map<String, String>;
    return _service.post('order/add', _header, params);
  }

  @override
  Future addwholselerparchaseorder(Map<String, String> params) async {
    final _header = await _service.generateHeaders() as Map<String, String>;
    return _service.post('order/purchase', _header, params);
  }

  @override
  Future getSize(String company_id) async {
    final _header = await _service.generateHeaders() as Map<String, String>;
    return _service.get('size/get?company_id=$company_id', _header);
  }

  @override
  Future getType() async {
    final _header = await _service.generateHeaders() as Map<String, String>;
    return _service.get('type/get', _header);
  }

  @override
  Future addretailer(Map<String, dynamic> params) async {
    final _header = await _service.generateHeaders() as Map<String, String>;
    _header.putIfAbsent('Content-Type', () => 'multipart/form-data');
    final _image = params['photo'] as File;
    params.remove('photo');
    String url = '';
    params.entries.forEach((element) {
      if (url.isNotEmpty) {
        url = '$url&';
      }
      url = '$url${element.key}=${element.value}';
    });

    final _designUrl = 'retailer/add?$url';
    if (_image != null) {
      return _service.postWithImage(
        _designUrl,
        _header,
        null,
        'photo',
        _image,
      );
    } else {
      return _service.post(_designUrl, _header, null);
    }
  }

  @override
  Future editretailer(Map<String, dynamic> params) async {
    final _header = await _service.generateHeaders() as Map<String, String>;
    _header.putIfAbsent('Content-Type', () => 'multipart/form-data');
    final _image = params['photo'] as File;
    params.remove('photo');
    String url = '';
    params.entries.forEach((element) {
      if (url.isNotEmpty) {
        url = '$url&';
      }
      url = '$url${element.key}=${element.value}';
    });

    final _designUrl = 'retailer/edit?$url';
    if (_image != null) {
      return _service.postWithImage(
        _designUrl,
        _header,
        null,
        'photo',
        _image,
      );
    } else {
      return _service.post(_designUrl, _header, null);
    }
  }

  @override
  Future getretailer() async {
    final _header = await _service.generateHeaders() as Map<String, String>;
    return _service.get('retailers', _header);
  }

  @override
  Future getdesign() async {
    final _header = await _service.generateHeaders() as Map<String, String>;
    return _service.get('design/get', _header);
  }

  @override
  Future getdesigndetail(String name) async {
    final _header = await _service.generateHeaders() as Map<String, String>;
    return _service.get('design/get?search=$name', _header);
  }

  @override
  Future adddesign(Map<String, dynamic> params) async {
    final _header = await _service.generateHeaders() as Map<String, String>;
    _header.putIfAbsent('Content-Type', () => 'multipart/form-data');
    final _image = params['image'] as File;
    params.remove('image');
    String url = '';
    params.entries.forEach((element) {
      if (url.isNotEmpty) {
        url = '$url&';
      }
      url = '$url${element.key}=${element.value}';
    });
    final _designUrl = 'design/add?$url';
    if (_image != null) {
      return _service.postWithImage(
        _designUrl,
        _header,
        null,
        'image',
        _image,
      );
    } else {
      return _service.post(_designUrl, _header, null);
    }
  }

  @override
  Future updateProfile(Map<String, dynamic> params) async {
    final _header = await _service.generateHeaders() as Map<String, String>;
    _header.putIfAbsent('Content-Type', () => 'multipart/form-data');

    final _image = params['photo'] as File;
    params.remove('photo');
    String url = '';
    params.entries.forEach((element) {
      if (url.isNotEmpty) {
        url = '$url&';
      }
      url = '$url${element.key}=${element.value}';
    });
    final _profileUrl = 'profile/edit?$url';

    if (_image != null) {
      return _service.postWithImage(
        _profileUrl,
        _header,
        null,
        'photo',
        _image,
      );
    } else {
      return _service.post(_profileUrl, _header, null);
    }
  }

  @override
  @override
  Future updatecompany(Map<String, String> params) async {
    final _header = await _service.generateHeaders() as Map<String, String>;
    return _service.post('company/edit', _header, params);
  }
}
