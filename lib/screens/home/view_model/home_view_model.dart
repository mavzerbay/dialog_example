import 'package:dialog_example/core/base/model/abstracts/base_view_model.dart';
import 'package:dialog_example/core/base/model/concrete/base_error.dart';
import 'package:dialog_example/core/components/dialog/mav_dialog.dart';
import 'package:dialog_example/core/constants/enums/http_request_enum.dart';
import 'package:dialog_example/core/init/network/network_manager.dart';
import 'package:dialog_example/core/init/network/network_route_enum.dart';
import 'package:dialog_example/screens/home/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    this.context = context;
    networkManager = NetworkManager()
        .addLoadersOnRequest()
        .addBaseUrl('https://jsonplaceholder.typicode.com')
        .addBuildContext(context)
        .addNavigationService(navigation)
        .build();
  }

  @override
  void init() {}

  @action
  getPosts() async {
    try {
      final response = await networkManager!.send<List<PostModel>, PostModel>(
        NetworkRoutes.POSTS.rawValue,
        parseModel: PostModel(),
        type: HttpTypes.GET,
        withAuth: false,
      );

      if (response.error != null) {
        if ((response.error as BaseError).closeLoader != null &&
            (response.error as BaseError).closeLoader!)
          Navigator.of(context!, rootNavigator: true).pop();

        MavDialog.showCustomDialogBox(
          context!,
          title: (response.error! as BaseError).error,
          descriptions: (response.error! as BaseError).description,
          acceptButtonText: "Tamam",
        );
      } else if (response.data != null) {
        MavDialog.showCustomDialogBox(
          context!,
          title: "İşlem Başarılı",
          acceptButtonText: "Tamam",
          icon: Icons.check,
          iconColor: Colors.green,
          isDismissible: false,
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
