import '../entity/child.dart';
import '../repositories/children_repository.dart';

class AddChild {
  final ChildrenRepository repository;

  AddChild(this.repository);

  Future<void> call(Child child) async {
    return await repository.addChild(child);
  }
}
