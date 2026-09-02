import '../../data/models/student_model.dart';

/// Calculates tuition due/advance for a student based on admission date.
/// Rule: the first month's fee becomes "due" only after a full month has
/// passed since admission (i.e. admission month itself has no due yet).
class FeeCalculator {
  FeeCalculator._();

  static int monthsSinceAdmission(DateTime admission, [DateTime? at]) {
    final now = at ?? DateTime.now();
    int months =
        (now.year - admission.year) * 12 + (now.month - admission.month);
    if (now.day < admission.day) months -= 1;
    if (months < 0) months = 0;
    return months;
  }

  static double totalExpected(Student s, [DateTime? at]) =>
      monthsSinceAdmission(s.admissionDate, at) * s.monthlyFee;

  static double due(Student s, double totalPaid, [DateTime? at]) {
    final diff = totalExpected(s, at) - totalPaid;
    return diff > 0 ? diff : 0;
  }

  static double advance(Student s, double totalPaid, [DateTime? at]) {
    final diff = totalPaid - totalExpected(s, at);
    return diff > 0 ? diff : 0;
  }
}
