import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sporty/providers/app_provider.dart';
import 'package:sporty/providers/login_provider.dart';
import 'package:sporty/providers/profile_provider.dart';
import 'package:sporty/providers/register_provider.dart';
import 'package:sporty/providers/reset_password_provider.dart';
import 'package:sporty/providers/settings_provider.dart';

final providers = <SingleChildWidget>[
  ChangeNotifierProvider(create: (_) => LoginProvider()),
  ChangeNotifierProvider(create: (_) => RegisterProvider()),
  ChangeNotifierProvider(create: (_) => ResetPasswordProvider()),
  ChangeNotifierProvider(create: (_) => AppProvider()),
  ChangeNotifierProvider(create: (_) => SettingsProvider()),
  ChangeNotifierProvider(create: (_) => ProfileProvider()),
];
