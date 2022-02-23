import 'dart:convert';
import 'package:crypto/crypto.dart';

String passwordGenerator(Map strings) {
  var symbols = '!#\$%&()*<=>?@[]^_{}~';
  var name = strings['name'] ?? 'tria';
  var code = strings['code'] ?? 'tria';
  var domain = strings['domain'] ?? 'tria';
  var bytes = utf8.encode("$name$domain");
  var hmac256 = Hmac(sha256, utf8.encode(code));
  var digest = hmac256.convert(bytes).toString();
  var password = '';
  for (var i = 0; i < 5; i++) {
    password += symbols[(bytes[0] + bytes[1]) % (symbols.length - i)];
  }
  password = digest.substring(0, 3) +
      password[0] +
      digest.substring(3, 6).toUpperCase() +
      password[1] +
      digest.substring(6, 9) +
      password[2] +
      digest.substring(9, 12).toUpperCase() +
      password[3];

  return password;
}
