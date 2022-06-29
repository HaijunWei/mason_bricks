import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app.dart';
import 'support_files/router.dart';

void main() {
  runApp(const {{name.pascalCase()}}App());
}

class {{name.pascalCase()}}App extends StatelessWidget {
  const {{name.pascalCase()}}App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '',
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      theme: appThemeData,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      builder: (context, child) {
        var rChild = child!;
        rChild = ScrollConfiguration(
          behavior: CustomScrollBehavior(),
          child: rChild,
        );
        
        return rChild;
      },
    );
  }
}
