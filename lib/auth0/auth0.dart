library auth0;

import 'dart:convert';
import 'dart:io';
import 'package:Deliciousness/widgets/InfoDialogPopUp.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:http/http.dart' as http;
import 'package:Deliciousness/utils/urls.dart' as urls;

part 'data/auth0_client.dart';

part 'data/network/dio_wrapper.dart';

part 'data/network/exception_handler.dart';

part 'domain/telemetry.dart';

part 'domain/user_info.dart';

part 'errors/auth_exeption.dart';

part 'errors/auth0_unauthorized_exception.dart';

