import 'package:freezed_annotation/freezed_annotation.dart';

part 'action_state.freezed.dart';

@freezed
class ActionState with _$ActionState {
  const factory ActionState.initial() = Initial;
  const factory ActionState.running() = Running;
  const factory ActionState.success({dynamic data}) = Success;
  const factory ActionState.failure(dynamic error) = Failure;
}
