import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sporty/providers/login_provider.dart';
import 'package:sporty/providers/register_provider.dart';

final providers = <SingleChildWidget>[
  ChangeNotifierProvider(create: (_) => LoginProvider()),
  ChangeNotifierProvider(create: (_) => RegisterProvider()),
];
