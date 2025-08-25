
import 'package:equatable/equatable.dart';

import '../../domain/entity/child.dart';

abstract class ChildrenState extends Equatable {
  const ChildrenState();

  @override
  List<Object?> get props => [];
}

class ChildrenInitial extends ChildrenState {}

class ChildrenLoading extends ChildrenState {}

class ChildrenLoaded extends ChildrenState {
  final List<Child> children;

  const ChildrenLoaded(this.children);

  @override
  List<Object?> get props => [children];
}

class ChildrenError extends ChildrenState {
  final String message;

  const ChildrenError(this.message);

  @override
  List<Object?> get props => [message];
}
