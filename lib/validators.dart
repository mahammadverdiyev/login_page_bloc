import 'dart:async';

mixin Validators {
  var usernameValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (username, eventSink) {
    if (username.trim().length >= 4 && username.trim().isNotEmpty) {
      eventSink.add(username);
    } else {
      eventSink.addError("Username must be larger than 3 characters");
    }
  });

  var passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, eventSink) {
    if (password.length > 0 && password[0] != password[0].toUpperCase()) {
      eventSink.addError("Password must start with Uppercase character!");
    } else if (password.trim().length < 4) {
      eventSink.addError("Password must be greater than 3 characters!");
    } else {
      eventSink.add(password);
    }
  });
}
