class Username {
  late String value;
  Username( String name) {
    if (name.isEmpty) {
      throw ArgumentError('Username cannot be empty');
    }
    value = name;
  }
}
