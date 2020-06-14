
import 'package:flutter/cupertino.dart';
class ApiResponse<T>{

  bool ok;
  String msg;
  T result;

  ApiResponse.ok({@required this.result}){
    this.ok = true;
  }

  ApiResponse.error({@required this.msg}){
    this.ok = false;
  }
}