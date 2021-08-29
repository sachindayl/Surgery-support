import 'package:flutter/cupertino.dart';
import 'package:wardeleven/base/base_styles.dart';

class AccountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      CupertinoSliverNavigationBar(
        largeTitle: Text('Account'),
      ),
      SliverToBoxAdapter(
        child: Container(
          height: 80.0,
          margin: const EdgeInsets.symmetric(vertical: 32.0),
          padding: const EdgeInsets.all(16.0),
          child: CupertinoButton(
            onPressed: () => '',
            color: CupertinoTheme.of(context).primaryColor,
            child: Text('Sign out', style: TextStyle(color: Styles.white),),
          ),
        ),
      )
    ]);
  }
}
