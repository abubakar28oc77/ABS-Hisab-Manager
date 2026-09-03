class ClassItem {
  final String id;
  String name;
  List<String> sections;
  List<String> subjects;

  ClassItem({
    required this.id,
    required this.name,
    List<String>? sections,
    List<String>? subjects,
  })  : sections = sections ?? ['A', 'B'],
        subjects = subjects ?? ['Bangla', 'English', 'Mathematics', 'Science'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'sections': sections,
        'subjects': subjects,
      };

  factory ClassItem.fromJson(Map<String, dynamic> json) => ClassItem(
        id: json['id'] as String,
        name: json['name'] as String,
        sections: (json['sections'] as List?)?.map((e) => e.toString()).toList() ??
            ['A', 'B'],
        subjects: (json['subjects'] as List?)?.map((e) => e.toString()).toList() ??
            ['Bangla', 'English', 'Mathematics', 'Science'],
      );
}
