import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:supabase_flutter/supabase_flutter.dart';

String  extractErrorMessage(Exception exception) {
  if (exception is AuthException) {
    return exception.message;
  }else if (exception is TimeoutException) {
    return exception.message??'Timeout check your internet connection';
  }else if (exception is SocketException) {
    return exception.message;
  }else if(exception is HandshakeException){
    return exception.message;
  }else{
    return 'Something went wrong';
  }
}