import 'package:price_finder/constants/environment.dart';
import 'package:price_finder/main_common.dart';

Future<void> main() async {
  await mainCommon(Environment.prod);
}