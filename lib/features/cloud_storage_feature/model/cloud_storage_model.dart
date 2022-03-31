import 'package:firebase_storage/firebase_storage.dart' as cloud_storage;

class CloudStorageModel {
  cloud_storage.FirebaseStorage storage =
      cloud_storage.FirebaseStorage.instance;
}
