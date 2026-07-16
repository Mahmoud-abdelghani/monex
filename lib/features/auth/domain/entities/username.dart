class Username {
  late String value;
  Username({required String name}) {
    if (name.isEmpty) {
      throw ArgumentError('Username cannot be empty');
    }
    value = name;
  }
}
