import 'dart:io';

import 'package:flutter/material.dart';

import '../../../components/dialog/mav_dialog.dart';
import '../../../constants/enums/locale_preferences_keys_enum.dart';
import '../../../init/cache/locale_manager.dart';
import '../../../init/navigation/navigation_service.dart';
import '../../../init/network/core_dio_interface.dart';
import '../../../utils/jwt_utils.dart';

abstract class BaseViewModel {
  BuildContext? context;

  ICoreDio? networkManager;

  // VexanaManager? vexanaManager;

  // VexanaManager get vexanaManagerComputed => VexanaManager.instance(context);

  LocaleManager localeManager = LocaleManager.instance;
  NavigationService navigation = NavigationService.instance;

  void setContext(BuildContext context);

  void init();

  Future<void> showLoaderDialog({String? text}) async {
    MavDialog.showLoaderDialog(context!, text: text);
  }

  hideLoaderDialog() {
    Navigator.of(context!, rootNavigator: true).pop();
  }

  //Get the access token of the logged in user
  Future<String> getAuthBearerToken() async {
    final token = LocaleManager.instance.getStringValue(LocalePreferencesKeys.TOKEN);
    if (token.isNotEmpty && !JwtUtils.isExpired(token)) {
      LocaleManager.instance.removeValue(LocalePreferencesKeys.TOKEN);
      MavDialog.showCustomDialogBox(context!,
          title: "Oturum Süreniz Doldu",
          acceptButtonText: "Tamam",
          acceptButtonFunc: () async =>
             await navigation.navigateToPageClear(path: ""));//Giriş sayfasına yönlendirme
    }
    return token.isNotEmpty ? token : "";
  }

  Future<Map<String, String>?> getHeaders() async {
    var token = await getAuthBearerToken();
    return {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
  }
}
