export '{{name}}_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '{{name}}_state.dart';

class {{name.pascalCase()}}Cubit extends Cubit<{{name.pascalCase()}}State> {
  {{name.pascalCase()}}Cubit() : super(const {{name.pascalCase()}}State());

  void loadData() async {}
}