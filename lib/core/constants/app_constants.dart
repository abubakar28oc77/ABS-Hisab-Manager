// Core enums & constants shared across the app.

enum TxnType { income, expense }

extension TxnTypeX on TxnType {
  String get label => this == TxnType.income ? 'Income' : 'Expense';
}

class AppConstants {
  AppConstants._();

  static const String studentsBox = 'students_box';
  static const String transactionsBox = 'transactions_box';
  static const String paymentsBox = 'payments_box';
  static const String settingsBox = 'settings_box';

  static const String pinKey = 'app_pin';
  static const String biometricKey = 'biometric_enabled';
  static const String currencyKey = 'currency_symbol';

  static const List<String> incomeCategories = <String>[
    'Tuition',
    'Salary',
    'Bonus',
    'Other Income',
  ];

  static const List<String> expenseCategories = <String>[
    'Food',
    'Travel',
    'Books',
    'Bills',
    'Rent',
    'Shopping',
    'Other',
  ];

  static const List<String> classGrades = <String>[
    'Six',
    'Seven',
    'Eight',
    'Nine',
    'Ten',
  ];

  static const List<String> months = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
}
