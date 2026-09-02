import 'package:flutter_test/flutter_test.dart';
import 'package:tutor_finance/main.dart';

void main() {
  testWidgets('App launches and shows Dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(const AbsHisabManagerApp());
    await tester.pumpAndSettle();
    expect(find.text('ABS Hisab Manager'), findsWidgets);
  });
}
