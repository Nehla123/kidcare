import 'package:cloudinary/cloudinary.dart';

Future<String?>  getClodinaryUrl(String image) async {

  final cloudinary = Cloudinary.signedConfig(
    cloudName: 'drj5snlmt',
    apiKey: '184672487928537',
    apiSecret: 'PJBrriaNt_ciEUVzVQAvSupxlsg',
  );

   final response = await cloudinary.upload(
        file: image,
        resourceType: CloudinaryResourceType.image,
      );
  return response.secureUrl;
  
} 