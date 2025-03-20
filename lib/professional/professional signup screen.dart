import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ProfessionalRegistrationForm extends StatefulWidget {
  const ProfessionalRegistrationForm({super.key});

  @override
  _ProfessionalRegistrationFormState createState() =>
      _ProfessionalRegistrationFormState();
}

class _ProfessionalRegistrationFormState
    extends State<ProfessionalRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = false;

  final _controllers = {
    'name': TextEditingController(),
    'email': TextEditingController(),
    'password': TextEditingController(),
    'confirmPassword': TextEditingController(),
    'qualification': TextEditingController(),
    'phone': TextEditingController(),
    'dob': TextEditingController(),
  };

  final List<String> _services = [
    'Medical Services',
    'Educational Support',
    'Community & Social',
    'Legal & Government',
    'Childcare & Miscellaneous',
  ];
  final List<bool> _selectedServices = List.filled(5, false);
  Uint8List? _profileImage;
  final ImagePicker _picker = ImagePicker();
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Uint8List imageBytes = await pickedFile.readAsBytes();
      setState(() {
        _profileImage = imageBytes;
      });
    } else {
      _showSnackBar("No image selected");
    }
  }

  Future<String?> _uploadProfileImage() async {
    if (_profileImage == null) return null;

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://api.cloudinary.com/v1_1/drj5snlmt/image/upload'),
      );

      request.fields['upload_preset'] = 'profile_images';
      request.files.add(http.MultipartFile.fromBytes('file', _profileImage!,
          filename: 'profile.jpg'));

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonData = jsonDecode(responseData);
        return jsonData['secure_url'];
      } else {
        _showSnackBar("Image upload failed");
        return null;
      }
    } catch (e) {
      print("Cloudinary upload error: $e");
      return null;
    }
  }

  Future<void> _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      final selectedServices = [
        for (int i = 0; i < _services.length; i++)
          if (_selectedServices[i]) _services[i],
      ];

      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _controllers['email']!.text.trim(),
          password: _controllers['password']!.text.trim(),
        );
  String? profileImageUrl = await _uploadProfileImage();
        await _firestore
            .collection('professionals')
            .doc(userCredential.user!.uid)
            .set({
          'name': _controllers['name']!.text.trim(),
          'email': _controllers['email']!.text.trim(),
          'qualification': _controllers['qualification']!.text.trim(),
          'phone': _controllers['phone']!.text.trim(),
          'dob': _controllers['dob']!.text.trim(),
          'services': selectedServices,
          'profileImage': profileImageUrl ?? '',
          'approve': false,
          'role': 'professional',
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Registration Successful! Welcome, ${_controllers['name']!.text}.')),
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.message}')),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  Widget _buildTextField(String labelText, String controllerKey, IconData icon,
      {bool obscure = false, TextInputType type = TextInputType.text}) {
    return TextFormField(
      controller: _controllers[controllerKey],
      obscureText: obscure,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $labelText';
        }
        return null;
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildProfileImagePicker() {
    return Center(
      child: Stack(
        children: [
        GestureDetector(
          onTap: _pickImage,
            child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage:
                        _profileImage != null ? MemoryImage(_profileImage!) : null,
                    child: _profileImage == null
                        ? Icon(Icons.camera_alt, color: Colors.grey[700], size: 30)
                        : null,
                  ),
          ),
    
        ],
      ),
    );
  }

  Widget _buildServiceCheckboxes() {
    return Column(
      children: List.generate(_services.length, (index) {
        return CheckboxListTile(
          title: Text(_services[index]),
          value: _selectedServices[index],
          onChanged: (bool? value) {
            setState(() {
              _selectedServices[index] = value ?? false;
            });
          },
        );
      }),
    );
  }

  Widget _buildDatePicker() {
    return TextFormField(
      controller: _controllers['dob'],
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Date of Birth',
        prefixIcon: Icon(Icons.calendar_today),
        border: OutlineInputBorder(),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          setState(() {
            _controllers['dob']!.text =
                '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Professional Registration')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildProfileImagePicker(),
              SizedBox(height: 20),
              _buildTextField('Full Name', 'name', Icons.person),
              SizedBox(height: 10),
              _buildTextField('Email', 'email', Icons.email,
                  type: TextInputType.emailAddress),
              SizedBox(height: 10),
              _buildTextField('Qualification', 'qualification', Icons.school),
              SizedBox(height: 10),
              _buildTextField('Phone Number', 'phone', Icons.phone,
                  type: TextInputType.phone),
              SizedBox(height: 10),
              _buildDatePicker(),
              SizedBox(height: 10),
              _buildTextField('Password', 'password', Icons.lock,
                  obscure: true),
              SizedBox(height: 10),
              _buildTextField('Confirm Password', 'confirmPassword', Icons.lock,
                  obscure: true),
              SizedBox(height: 20),
              Text('Select Services:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              _buildServiceCheckboxes(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _register,
                child:
                    _isLoading ? CircularProgressIndicator() : Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
