import 'package:cloudinary/cloudinary.dart';

Future<String?>  getClodinaryUrl(String image) async {

  final cloudinary = Cloudinary.signedConfig(
    cloudName: 'dykp7wmhj',
    apiKey: '156995591465189',
    apiSecret: 'snLV8BBISMJsn523b3DQul2jgho',
  );

   final response = await cloudinary.upload(
        file: image,
        resourceType: CloudinaryResourceType.image,
      );
  return response.secureUrl;
  
} 