import 'package:freezed_annotation/freezed_annotation.dart';

part '{{name}}_state.freezed.dart';

@freezed
class {{name.pascalCase()}}State with _${{name.pascalCase()}}State {
  const factory {{name.pascalCase()}}State() = _{{name.pascalCase()}}State;
}
