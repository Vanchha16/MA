import 'package:first_app/main.dart';
import 'package:first_app/screen/splash_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Splash screen to home screen tabs smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    // Verify splash screen is displayed initially
    expect(find.byType(SplashScreen), findsOneWidget);

    // Advance timer to trigger navigation
    await tester.pump(const Duration(seconds: 4));
    await tester.pump(const Duration(milliseconds: 600));

    // Verify all 5 footer tabs are rendered on HomeScreen
    expect(find.text('Shop'), findsOneWidget);
    expect(find.text('Explore'), findsOneWidget);
    expect(find.text('Cart'), findsOneWidget);
    expect(find.text('Favourite'), findsOneWidget);
    expect(find.text('Account'), findsOneWidget);
  });
}
