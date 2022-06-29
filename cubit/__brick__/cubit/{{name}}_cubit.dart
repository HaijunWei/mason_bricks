export '{{name}}_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '{{name}}_state.dart';

class {{name.pascalCase()}}Cubit extends {{name.pascalCase()}}Cubit<State> {
  {{name.pascalCase()}}Cubit() : super(const {{name.pascalCase()}}State());

  void loadData() async {}
}