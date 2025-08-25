import '../../domain/entity/child.dart';
import '../../domain/repositories/children_repository.dart';
import '../datasource/children_remote_datasource.dart';
import '../models/child_model.dart';

class ChildrenRepositoryImpl implements ChildrenRepository {
  final ChildrenRemoteDataSource remoteDataSource;

  ChildrenRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Child>> getChildren() => remoteDataSource.getChildren();

  @override
  Future<void> addChild(Child child) =>
      remoteDataSource.addChild(ChildModel(
        id: child.id,
        name: child.name,
        birthDate: child.birthDate,
        weight: child.weight,
        height: child.height,
        headCircumference: child.headCircumference,
        notes: child.notes,
        doctorId: child.doctorId,
      ));

  @override
  Future<void> deleteChild(String id) => remoteDataSource.deleteChild(id);
}
