import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:price_finder/common_screens/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  testWidgets(
    "Test search button",
    (WidgetTester tester) async {
      final searchButton = find.byKey(const ValueKey("SearchButton"));
      await tester.pumpWidget(
        MaterialApp(
          home: ScreenUtilInit(
            designSize: const Size(1440, 2960),
            builder: (context, widget) {
              return const MaterialApp(
                home: HomeScreen(),
              );
            },
          ),
        ),
      );
      await tester.pump();
      await tester.tap(searchButton);
      await tester.pump();
      expect(find.byType(CupertinoAlertDialog), findsOneWidget);
    },
  );
}
