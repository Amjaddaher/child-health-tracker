
// 2️⃣ Model (data layer) extends the entity
import '../../domain/entities/vaccine_catalog_item.dart';

class VaccineCatalogItemModel extends VaccineCatalogItem {
  const VaccineCatalogItemModel({
    required super.code,
    required super.name,
    super.recommendedAgeDays,
    super.defaultDoses,
    super.doseSpacingDays,
  });

  // Factory to create model from Supabase map
  factory VaccineCatalogItemModel.fromMap(Map<String, dynamic> map) {
    return VaccineCatalogItemModel(
      code: map['code'] as String,
      name: map['name'] as String,
      recommendedAgeDays: map['recommended_age_days'] != null
          ? map['recommended_age_days'] as int
          : null,
      defaultDoses: map['default_doses'] != null
          ? map['default_doses'] as int
          : 1,
      doseSpacingDays: map['dose_spacing_days'] != null
          ? map['dose_spacing_days'] as int
          : null,
    );
  }

  // Convert model to Map (for Supabase)
  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'recommended_age_days': recommendedAgeDays,
      'default_doses': defaultDoses,
      'dose_spacing_days': doseSpacingDays,
    };
  }
}