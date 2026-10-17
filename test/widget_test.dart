import 'package:final_project/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('home lists categories and opens one', (tester) async {
    await tester.pumpWidget(const MyApp());

    for (final name in ['Love', 'Life', 'Quotes', 'Islamic']) {
      expect(find.text(name), findsOneWidget);
    }

    await tester.tap(find.text('Love'));
    await tester.pumpAndSettle();
    expect(find.text('Love Page'), findsOneWidget);
  });
}
