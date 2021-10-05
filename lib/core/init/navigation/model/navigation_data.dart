import 'package:dialog_example/core/init/navigation/model/navigation_data_abstract.dart';

class NavigationData extends INavigationData {
  @override
  Object? data;
  @override
  bool routeWithAnimation;

  NavigationData({this.data, this.routeWithAnimation = false});
}
