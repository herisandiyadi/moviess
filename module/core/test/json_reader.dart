import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  print('$dir/test/$name');
  return File('$dir/module/core/test/$name').readAsStringSync();
}
