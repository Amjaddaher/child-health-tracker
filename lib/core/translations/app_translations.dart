// lib/core/translations/app_translations.dart
import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      // Auth
      'auth.login_title': 'Login',
      'auth.email': 'Email',
      'auth.password': 'Password',
      'auth.login_button': 'Login',
      'auth.no_account': "Don't have an account? Sign Up",
      'auth.signup_title': 'Sign Up',
      'auth.signup_button': 'Sign Up',
      'auth.logout': 'Logout',
      'auth.logout_confirm_title': 'Logout',
      'auth.logout_confirm_body': 'Are you sure you want to logout?',

      // Common
      'common.error': 'Error',
      'common.error_with_message': 'Error: @msg',
      'common.cancel': 'Cancel',
      'common.save': 'Save',
      'common.add': 'Add',
      'common.required': 'Required',
      'common.change': 'Change',
      'common.no_data': 'No data',
      'common.no_items': 'No items',
      'common.yes': 'Yes',
      'common.no_date_chosen': 'No date chosen',
      'common.delete': 'Delete',
      'common.no':'No',

      // Children
      'children.title': 'Children',
      'children.no_data': 'No data',
      'children.add_dialog_title': 'Add new child',
      'children.name': "Child's Name",
      'children.weight': 'Weight (kg)',
      'children.height': 'Height (cm)',
      'children.head_circ': 'Head circumference (cm)',
      'children.notes': 'Notes',
      'children.cancel': 'Cancel',
      'children.save': 'Save',
      'children.details': 'Weight: %s kg\nHeight: %s cm\nHead circumference: %s cm',
      'children.delete_confirmation': 'Delete child?',
      'children.add': 'Children Add',

      // Dashboard / tabs
      'dashboard.child_info': 'Child info',
      'dashboard.growth': 'Growth',
      'dashboard.vaccinations': 'Vaccinations',
      'dashboard.visits': 'Doctor visits',
      'dashboard.reminders': 'Reminders',
      'dashboard.select_child_for_growth': 'Select a child to view growth',
      'dashboard.select_child_for_vaccines': 'Select a child to view vaccinations',
      'dashboard.select_child_for_visits': 'Select a child to view doctor visits',
      'dashboard.select_child_for_reminders': 'Select a child to view reminders',
      'dashboard.unknown': 'Unknown',

      // Growth
      'growth.title': 'Growth tracking',
      'growth.weight_title': 'Weight (kg)',
      'growth.height_title': 'Height (cm)',
      'growth.head_title': 'Head circumference (cm)',
      'growth.no_measurements': 'No measurements yet',
      'growth.no_enough_data': 'Not enough data',
      'growth.measurements_label': 'Measurements',
      'growth.measurement_item': 'Weight: %s | Height: %s | Head: %s',

      // Add Measurement
      'add_measurement.title': 'Add measurement',
      'add_measurement.date': 'Date',
      'add_measurement.weight_label': 'Weight (kg)',
      'add_measurement.weight_hint': 'Example: 8.4',
      'add_measurement.height_label': 'Height (cm)',
      'add_measurement.height_hint': 'Example: 72.5',
      'add_measurement.head_label': 'Head circumference (cm)',
      'add_measurement.head_hint': 'Example: 43.2',
      'add_measurement.save': 'Save',
      'add_measurement.invalid_number': 'Invalid value',
      'add_measurement.negative_number': 'Cannot be negative',

      // Health record
      'health_record.appbar': 'Health Records',
      'health_record.title_label': 'Title',
      'health_record.notes_label': 'Notes',
      'health_record.add_button': 'Add',
      'health_record.required': 'Required',
      'health_record.no_records': 'No health records yet.',
      'health_record.delete_confirm_title': 'Delete record',
      'health_record.delete_confirm_body':
      'Delete record \"{details}\" dated {date}? This action cannot be undone.',
      'health_record.deleted': 'Record deleted',
      'health_record.add': 'Add record',

      // Reminders
      'reminders.title': 'Reminders',
      'reminders.no_reminders': 'No reminders yet',
      'reminders.due': 'Due: @date',
      'reminders.edit': 'Edit',
      'reminders.delete': 'Delete',
      'reminders.complete': 'Complete',
      'reminders.uncomplete': 'Uncomplete',
      'reminders.new_title': 'New Reminder',
      'reminders.edit_title': 'Edit Reminder',
      'reminder_form.title_label': 'Title',
      'reminder_form.notes_label': 'Notes',
      'reminder_form.required': 'Required',
      'reminder_form.change': 'Change',
      'reminder_form.cancel': 'Cancel',
      'reminder_form.save': 'Save',

      // Vaccinations
      'vaccinations.title': 'Vaccinations',
      'vaccinations.no_vaccinations': 'No vaccinations found',
      'vaccinations.add_vaccination': 'Add Vaccination',
      'vaccinations.vaccine_name': 'Vaccine Name',
      'vaccinations.dose_number': 'Dose Number',
      'vaccinations.location_optional': 'Location (optional)',
      'vaccinations.notes_optional': 'Notes (optional)',
      'vaccinations.enter_name': 'Enter vaccine name',
      'vaccinations.enter_dose': 'Enter dose number',
      'vaccinations.scheduled': 'Scheduled: @date',
      'vaccinations.status': 'Status: @status',
      'vaccinations.mark_administered': 'Mark as Administered',
      'vaccinations.delete': 'Delete',
      'vaccinations.no_date_chosen': 'No date chosen',
      'vaccinations.add': 'Add',

      // Popup menu generic
      'popup.edit': 'Edit',
      'popup.delete': 'Delete',
    },

    'ar_AR': {
      // Auth
      'auth.login_title': 'تسجيل الدخول',
      'auth.email': 'البريد الإلكتروني',
      'auth.password': 'كلمة المرور',
      'auth.login_button': 'تسجيل الدخول',
      'auth.no_account': 'ليس لديك حساب؟ سجل',
      'auth.signup_title': 'تسجيل',
      'auth.signup_button': 'تسجيل',
      'auth.logout': 'تسجيل الخروج',
      'auth.logout_confirm_title': 'تأكيد تسجيل الخروج',
      'auth.logout_confirm_body': 'هل أنت متأكد أنّك تريد تسجيل الخروج؟',



      // Common
      'common.error': 'خطأ',
      'common.error_with_message': 'خطأ: @msg',
      'common.cancel': 'إلغاء',
      'common.save': 'حفظ',
      'common.add': 'إضافة',
      'common.required': 'مطلوب',
      'common.change': 'تغيير',
      'common.no_data': 'لا توجد بيانات',
      'common.no_items': 'لا توجد عناصر',
      'common.yes': 'نعم',
      'common.no_date_chosen': 'لم يتم اختيار تاريخ',
      'common.delete': 'حذف',
      'common.no':'لا',

      // Children
      'children.title': 'الأطفال',
      'children.no_data': 'لا توجد بيانات',
      'children.add_dialog_title': 'إضافة طفل جديد',
      'children.name': 'اسم الطفل',
      'children.weight': 'الوزن (كغ)',
      'children.height': 'الطول (سم)',
      'children.head_circ': 'محيط الرأس (سم)',
      'children.notes': 'ملاحظات',
      'children.cancel': 'إلغاء',
      'children.save': 'حفظ',
      'children.details': 'الوزن: %s كغ\nالطول: %s سم\nمحيط الرأس: %s سم',
      'children.delete_confirmation': 'حذف الطفل؟',
      'children.add':'إضافة طفل',

      // Dashboard / tabs
      'dashboard.child_info': 'معلومات الطفل',
      'dashboard.growth': 'النمو',
      'dashboard.vaccinations': 'التطعيمات',
      'dashboard.visits': 'زيارات الطبيب',
      'dashboard.reminders': 'التذكيرات',
      'dashboard.select_child_for_growth': 'اختر طفلاً لمتابعة النمو',
      'dashboard.select_child_for_vaccines': 'اختر طفلاً لمتابعة التطعيمات',
      'dashboard.select_child_for_visits': 'اختر طفلاً لمتابعة زيارات الطبيب',
      'dashboard.select_child_for_reminders': 'اختر طفلاً لمتابعة التذكيرات',
      'dashboard.unknown': 'غير معروف',

      // Growth
      'growth.title': 'متابعة النمو',
      'growth.weight_title': 'الوزن (كجم)',
      'growth.height_title': 'الطول (سم)',
      'growth.head_title': 'محيط الرأس (سم)',
      'growth.no_measurements': 'لا توجد قياسات بعد',
      'growth.no_enough_data': 'لا توجد بيانات كافية',
      'growth.measurements_label': 'القياسات',
      'growth.measurement_item': 'وزن: %s | طول: %s | محيط: %s',

      // Add Measurement
      'add_measurement.title': 'إضافة قياس',
      'add_measurement.date': 'التاريخ',
      'add_measurement.weight_label': 'الوزن (كجم)',
      'add_measurement.weight_hint': 'مثال: 8.4',
      'add_measurement.height_label': 'الطول (سم)',
      'add_measurement.height_hint': 'مثال: 72.5',
      'add_measurement.head_label': 'محيط الرأس (سم)',
      'add_measurement.head_hint': 'مثال: 43.2',
      'add_measurement.save': 'حفظ',
      'add_measurement.invalid_number': 'قيمة غير صالحة',
      'add_measurement.negative_number': 'لا يمكن أن تكون سالبة',

      // Health record
      'health_record.appbar': 'السجلات الصحية',
      'health_record.title_label': 'العنوان',
      'health_record.notes_label': 'ملاحظات',
      'health_record.add_button': 'إضافة',
      'health_record.required': 'مطلوب',
      'health_record.no_records': 'لا توجد سجلات صحية حتى الآن.',
      'health_record.delete_confirm_title': 'حذف السجل',
      'health_record.delete_confirm_body':
      'هل تريد حذف السجل \"{details}\" بتاريخ {date}؟ لا يمكن التراجع عن هذا الإجراء.',
      'health_record.deleted': 'تم حذف السجل',
      'health_record.add': 'إضافة سجل',

      // Reminders
      'reminders.title': 'التذكيرات',
      'reminders.no_reminders': 'لا توجد تذكيرات',
      'reminders.due': 'مستحق: @date',
      'reminders.edit': 'تعديل',
      'reminders.delete': 'حذف',
      'reminders.complete': 'مكتمل',
      'reminders.uncomplete': 'إلغاء الاكتمال',
      'reminders.new_title': 'تذكير جديد',
      'reminders.edit_title': 'تعديل التذكير',
      'reminder_form.title_label': 'العنوان',
      'reminder_form.notes_label': 'ملاحظات',
      'reminder_form.required': 'مطلوب',
      'reminder_form.change': 'تغيير',
      'reminder_form.cancel': 'إلغاء',
      'reminder_form.save': 'حفظ',

      // Vaccinations
      'vaccinations.title': 'التطعيمات',
      'vaccinations.no_vaccinations': 'لا توجد تطعيمات',
      'vaccinations.add_vaccination': 'إضافة تطعيم',
      'vaccinations.vaccine_name': 'اسم اللقاح',
      'vaccinations.dose_number': 'رقم الجرعة',
      'vaccinations.location_optional': 'المكان (اختياري)',
      'vaccinations.notes_optional': 'ملاحظات (اختياري)',
      'vaccinations.enter_name': 'أدخل اسم اللقاح',
      'vaccinations.enter_dose': 'أدخل رقم الجرعة',
      'vaccinations.scheduled': 'مجدول: @date',
      'vaccinations.status': 'الحالة: @status',
      'vaccinations.mark_administered': 'تحديد كمأعطى',
      'vaccinations.delete': 'حذف',
      'vaccinations.no_date_chosen': 'لم يتم اختيار تاريخ',
      'vaccinations.add': 'إضافة',

      // Popup menu generic
      'popup.edit': 'تعديل',
      'popup.delete': 'حذف',

    },
  };
}
