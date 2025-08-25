import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entity/child.dart';
import '../../domain/usecase/add_children.dart';
import '../../domain/usecase/delete_child.dart';
import '../../domain/usecase/get_children.dart';
import 'children_state.dart';

part 'children_event.dart';

class ChildrenBloc extends Bloc<ChildrenEvent, ChildrenState> {
  final GetChildren getChildren;
  final AddChild addChild;
  final DeleteChild deleteChild;

  ChildrenBloc({
    required this.getChildren,
    required this.addChild,
    required this.deleteChild,
  }) : super(ChildrenInitial()) {
    on<LoadChildren>((event, emit) async {
      emit(ChildrenLoading());
      try {
        final children = await getChildren();
        emit(ChildrenLoaded(children));
      } catch (e) {
        emit(ChildrenError(e.toString()));
      }
    });

    on<AddChildEvent>((event, emit) async {
      emit(ChildrenLoading()); // show progress
      try {
        await addChild(event.child);
        final children = await getChildren(); //  reload fresh list directly
        emit(ChildrenLoaded(children));
      } catch (e) {
        print(e);
        emit(ChildrenError(e.toString()));
      }
    });

    on<DeleteChildEvent>((event, emit) async {
      try {
        await deleteChild(event.id);
        add(LoadChildren());
      } catch (e) {
        emit(ChildrenError(e.toString()));
      }
    });
  }
}
