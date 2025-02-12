import 'package:cloudinary/cloudinary.dart';

Future<String?> uploadImageToCloudinary(String filePath) async {
  final cloudinary = Cloudinary.signedConfig(
    apiKey: "156995591465189",
    apiSecret: "snLV8BBISMJsn523b3DQul2jgho",
    cloudName: "dykp7wmhj",
  );

  final response = await cloudinary.upload(
    file: filePath,
    resourceType: CloudinaryResourceType.image,
    folder: "flutter_uploads", // Optional: Cloudinary folder name
  );

  return response.secureUrl; // Returns the uploaded image URL
}