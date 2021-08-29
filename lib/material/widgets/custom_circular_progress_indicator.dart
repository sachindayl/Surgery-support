import 'package:flutter/material.dart';
import 'package:wardeleven/models/enums.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final LoadingState isLoading;

  CustomCircularProgressIndicator({this.isLoading = LoadingState.loading});

  @override
  Widget build(BuildContext context) {
    return isLoading == LoadingState.loading
        ? Container(
      alignment: Alignment.center,
      child: SizedBox(
        child: CircularProgressIndicator(
          backgroundColor: Theme.of(context).primaryColorLight,
          valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).accentColor),
        ),
        width: 40,
        height: 40,
      ),
    )
        : Container();
  }
}