import '../repositories/children_repository.dart';

class DeleteChild {
  final ChildrenRepository repository;

  DeleteChild(this.repository);

  Future<void> call(String id) async {
    return await repository.deleteChild(id);
  }
}
