import '../entity/child.dart';
import '../repositories/children_repository.dart';

class GetChildren {
  final ChildrenRepository repository;

  GetChildren(this.repository);

  Future<List<Child>> call() async {
    return await repository.getChildren();
  }
}
