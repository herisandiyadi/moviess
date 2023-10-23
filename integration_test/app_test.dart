import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ditonton/main.dart' as app;

void main() {
  group('Testing App', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    final watchlistButton = find.byKey(const Key('add_watchlist'));
    final iconCheck = find.byIcon(Icons.check);
    final removeWatchlist = find.byKey(const Key('remove_watchlist'));
    final iconAdd = find.byIcon(Icons.add);
    final iconBack = find.byKey(Key('backtoHome'));
    final tapSeeMore = find.byKey(Key(
      'seemore-nowplaying',
    ));

    testWidgets('Integration Test', (widgetTester) async {
      app.main();
      await widgetTester.pumpAndSettle();

      final movieItem = find.byKey(ObjectKey('listview-nowplaying')).first;
      await widgetTester.tap(movieItem);
      await widgetTester.pumpAndSettle(Duration(seconds: 1));

      await widgetTester.tap(watchlistButton);
      await widgetTester.pumpAndSettle(Duration(seconds: 4));
      expect(iconCheck, findsOneWidget);

      await widgetTester.tap(removeWatchlist);
      await widgetTester.pumpAndSettle(Duration(seconds: 3));
      expect(iconAdd, findsOneWidget);

      await widgetTester.tap(iconBack);
      await widgetTester.pumpAndSettle(Duration(seconds: 3));

      await widgetTester.tap(tapSeeMore);
      await widgetTester.pumpAndSettle(Duration(seconds: 3));

      await widgetTester.pageBack();
      await widgetTester.pumpAndSettle(Duration(seconds: 3));
    });
  });
}
