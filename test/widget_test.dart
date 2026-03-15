import 'package:flutter_test/flutter_test.dart';
import 'package:neon_dash/main.dart';

void main() {
  testWidgets('Neon Dash game screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const NeonDashApp());

    // Verify that the game screen is displayed.
    expect(find.byType(GameScreen), findsOneWidget);
  });
}
