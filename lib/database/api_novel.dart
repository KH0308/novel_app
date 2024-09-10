import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiNovel {
  final String baseUrl = 'https://test-api.kacs.my/api';
  final String token =
      'd2af211e09cd42823dd5c7d74bc5007ecb561e82d1c6cc7c1a325d5be9eb29aee81ecf671ce842e42acc3263c2f10271bc74cc365e363c7e3c9e79eb04058b75ca6d933503363c768a225acc8d868c7ae90796820910eb01f4c6df2995453f781c1d4458b6e9d366cfe879d720b83306526b5b5eeb44cab52f5f4c0d3427c686';

  Future<Map<String, dynamic>> authSignIn(String phoneNumAsIdentifier) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'identifier': phoneNumAsIdentifier,
      }),
    );

    if (response.statusCode == 200) {
      debugPrint('Sign In successful');
      return json.decode(response.body);
    } else {
      throw Exception('Failed to sign in');
    }
  }

  Future<Map<String, dynamic>> authSignUp(
      String email,
      String firstName,
      String lastName,
      String gender,
      String countryCode,
      String phoneNumber) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
        'countryCode': countryCode,
        'phoneNumber': phoneNumber,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint('Sign Up successful');
      return json.decode(response.body);
    } else {
      throw Exception('Failed to sign up');
    }
  }

  Future<void> authOTP(String phoneNumAsIdentifier, String codeOTP) async {
    final response = await http.post(
      Uri.parse('$baseUrl/validateOtp'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'identifier': phoneNumAsIdentifier,
        'code': codeOTP,
      }),
    );

    if (response.statusCode == 200) {
      debugPrint('OTP Verification successful');
    } else {
      throw Exception('Failed to verify OTP');
    }
  }

  Future<List<dynamic>> fetchNovelLists() async {
    final response = await http.get(Uri.parse('$baseUrl/fetchNovel'), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load novels');
    }
  }

  Future<Map<String, dynamic>> fetchNovelDetails(String idNovel) async {
    final response =
        await http.get(Uri.parse('$baseUrl/novel/$idNovel'), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load novel details');
    }
  }
}
