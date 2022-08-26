import 'package:hive/hive.dart';
import 'package:movielab/models/hive/hive_helper/fields/user_fields.dart';
import 'package:movielab/models/hive/hive_helper/hive_adapters.dart';
import 'package:movielab/models/hive/hive_helper/hive_types.dart';

part 'user.g.dart';

@HiveType(typeId: HiveTypes.user, adapterName: HiveAdapters.user)
class HiveUser extends HiveObject {
  @HiveField(UserFields.name)
  late String name;
  @HiveField(UserFields.username)
  late String username;
  @HiveField(UserFields.imageUrl)
  late String imageUrl;

  // factory HiveUser.fromJson(Map<String, dynamic> json) {
  //   return HiveUser..name = json['name']..username = json['username']..imageUrl = json['imageUrl'];
  // }
}
