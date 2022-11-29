import 'package:flutter/material.dart';
import 'package:wardeleven/base/base_styles.dart';
import 'package:wardeleven/models/enums.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final LoadingState isLoading;

  CustomCircularProgressIndicator({this.isLoading = LoadingState.loading});

  @override
  Widget build(BuildContext context) {
    return isLoading == LoadingState.loading
        ? AbsorbPointer(
            absorbing: true,
            child: Container(
              alignment: Alignment.center,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 80.0,
                  width: 80.0,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius:
                          BorderRadius.circular(Styles.itemBorderRadius)),
                  child: Center(
                    child: Container(
                      height: 40.0,
                      width: 40.0,
                      child: CircularProgressIndicator(
                        backgroundColor: Theme.of(context).primaryColorLight,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).accentColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        : Container();
  }
}
