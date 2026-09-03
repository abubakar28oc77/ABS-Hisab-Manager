import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../data/local/database_helper.dart';
import '../data/models/class_model.dart';

class ClassProvider extends ChangeNotifier {
  static const String _storageKey = 'managed_classes_v1';
  final DatabaseHelper _db = DatabaseHelper.instance;
  final _uuid = const Uuid();

  List<ClassItem> _classes = [];
  List<ClassItem> get classes => List.unmodifiable(_classes);

  ClassProvider() {
    loadClasses();
  }

  void loadClasses() {
    final raw = _db.getSetting<String>(_storageKey);
    if (raw != null && raw.isNotEmpty) {
      try {
        final List list = jsonDecode(raw) as List;
        _classes = list
            .map((e) => ClassItem.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList();
        notifyListeners();
        return;
      } catch (e) {
        debugPrint('Failed to decode classes: $e');
      }
    }

    // Default classes if none exist yet
    _classes = [
      ClassItem(
        id: 'c-6',
        name: 'Class 6',
        sections: ['A', 'B', 'Morning'],
        subjects: ['Bangla', 'English', 'Mathematics', 'General Science', 'ICT'],
      ),
      ClassItem(
        id: 'c-7',
        name: 'Class 7',
        sections: ['A', 'B', 'Morning'],
        subjects: ['Bangla', 'English', 'Mathematics', 'General Science', 'ICT'],
      ),
      ClassItem(
        id: 'c-8',
        name: 'Class 8',
        sections: ['A', 'B', 'Morning'],
        subjects: ['Bangla', 'English', 'Mathematics', 'General Science', 'ICT'],
      ),
      ClassItem(
        id: 'c-9',
        name: 'Class 9',
        sections: ['A', 'B', 'Science', 'Commerce', 'Arts'],
        subjects: ['Bangla', 'English', 'Higher Math', 'Physics', 'Chemistry', 'Biology'],
      ),
      ClassItem(
        id: 'c-10',
        name: 'Class 10',
        sections: ['A', 'B', 'Science', 'Commerce', 'Arts'],
        subjects: ['Bangla', 'English', 'Higher Math', 'Physics', 'Chemistry', 'Biology'],
      ),
    ];
    _save();
    notifyListeners();
  }

  Future<void> _save() async {
    final raw = jsonEncode(_classes.map((c) => c.toJson()).toList());
    await _db.setSetting(_storageKey, raw);
  }

  Future<void> addClass({
    required String name,
    List<String>? sections,
    List<String>? subjects,
  }) async {
    final item = ClassItem(
      id: _uuid.v4(),
      name: name.trim(),
      sections: sections ?? ['A', 'B'],
      subjects: subjects ?? ['Bangla', 'English', 'Mathematics', 'Science'],
    );
    _classes.add(item);
    await _save();
    notifyListeners();
  }

  Future<void> updateClass(ClassItem item) async {
    final index = _classes.indexWhere((c) => c.id == item.id);
    if (index != -1) {
      _classes[index] = item;
      await _save();
      notifyListeners();
    }
  }

  Future<void> deleteClass(String id) async {
    _classes.removeWhere((c) => c.id == id);
    await _save();
    notifyListeners();
  }

  ClassItem? byName(String name) {
    try {
      return _classes.firstWhere(
        (c) => c.name.trim().toLowerCase() == name.trim().toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }

  List<String> get classNames => _classes.map((c) => c.name).toList();

  List<String> getSectionsForClass(String className) {
    final found = byName(className);
    if (found != null && found.sections.isNotEmpty) {
      return found.sections;
    }
    return ['A', 'B', 'C', 'Morning', 'Day'];
  }

  List<String> getSubjectsForClass(String className) {
    final found = byName(className);
    if (found != null && found.subjects.isNotEmpty) {
      return found.subjects;
    }
    return ['Bangla', 'English', 'Mathematics', 'Science'];
  }
}
