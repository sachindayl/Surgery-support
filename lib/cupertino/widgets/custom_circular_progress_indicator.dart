import 'package:flutter/cupertino.dart';
import 'package:wardeleven/base/base_styles.dart';
import 'package:wardeleven/models/enums.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final LoadingState isLoading;

  CustomCircularProgressIndicator({this.isLoading = LoadingState.loading});

  @override
  Widget build(BuildContext context) {
    return isLoading == LoadingState.loading
        ? Container(
            color: Styles.white.withOpacity(0.0),
            alignment: Alignment.center,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                height: 80.0,
                width: 80.0,
                decoration: BoxDecoration(
                    color: CupertinoTheme.of(context).primaryContrastingColor,
                    borderRadius:
                        BorderRadius.circular(Styles.itemBorderRadius)),
                child: SizedBox(
                  child: CupertinoActivityIndicator(
                    animating: true,
                  ),
                  width: 40,
                  height: 40,
                ),
              ),
            ),
          )
        : Container();
  }
}
