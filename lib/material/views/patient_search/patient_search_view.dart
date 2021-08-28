import 'package:flutter/material.dart';

class PatientSearchView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
                title: Text('Patient search'),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.search),
                    tooltip: 'Search',
                    onPressed: () { /* ... */ },
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter_alt),
                    tooltip: 'Search',
                    onPressed: () { /* ... */ },
                  ),
                ]
            ),
          ],
        ),
      ),
    );
  }
}