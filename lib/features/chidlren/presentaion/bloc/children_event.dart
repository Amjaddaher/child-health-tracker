part of 'children_bloc.dart';

abstract class ChildrenEvent extends Equatable {
  const ChildrenEvent();

  @override
  List<Object?> get props => [];
}

class LoadChildren extends ChildrenEvent {}

class AddChildEvent extends ChildrenEvent {
  final Child child;

  const AddChildEvent(this.child);

  @override
  List<Object?> get props => [child];
}

class DeleteChildEvent extends ChildrenEvent {
  final String id;

  const DeleteChildEvent(this.id);

  @override
  List<Object?> get props => [id];
}
