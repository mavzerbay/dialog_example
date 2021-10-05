import 'package:dialog_example/core/base/view/base_view.dart';
import 'package:dialog_example/core/components/button/base_elevated_button.dart';
import 'package:dialog_example/screens/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      viewModel: HomeViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, HomeViewModel viewModel) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BaseElevatedButton(
                onPressed: () async => await viewModel.getPosts(),
                child: Text("Veri Çek"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
