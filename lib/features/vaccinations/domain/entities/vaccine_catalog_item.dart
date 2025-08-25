import 'package:equatable/equatable.dart';

class VaccineCatalogItem extends Equatable {
  final String code;
  final String name;
  final int? recommendedAgeDays;
  final int defaultDoses;
  final int? doseSpacingDays;

  const VaccineCatalogItem({
    required this.code,
    required this.name,
    this.recommendedAgeDays,
    this.defaultDoses = 1,
    this.doseSpacingDays,
  });

  @override
  List<Object?> get props => [code, name, recommendedAgeDays, defaultDoses, doseSpacingDays];
}
