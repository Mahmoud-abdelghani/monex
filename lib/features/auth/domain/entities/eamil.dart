class Email {
  final String value;
  Email(this.value){
    if(value.isEmpty){
      throw ArgumentError('Email cannot be empty');
    } if(!value.contains('@')) {
      throw ArgumentError('Invalid email format');
    }
  }
}
