import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FireStoreServices {
  FireStoreServices({required this.userUid});
  final String userUid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser() async {
    final Map<String, dynamic> data = <String, dynamic>{
      'code': '001',
      'description': 'Dell',
      'specs': 'Core i5',
      'imageUrl':
          'https://images.pexels.com/photos/205421/pexels-photo-205421.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'isAssigned': 'false',
      'assignedTo': 'rm15@gmail.com',
    };

    final DocumentReference documentReferencer =
        _firestore.collection('equipment').doc();

    await documentReferencer.set(data).whenComplete(() {
      if (kDebugMode) {
        print('User added to the database');
      }
    }).catchError((e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    });
  }

  Future<void> addEquipment(String code, String description, String specs,
      String imageUrl, bool isAssigned, String assignedTo) async {
    final Map<String, dynamic> data = <String, dynamic>{
      'code': code,
      'description': description,
      'specs': specs,
      'imageUrl': imageUrl,
      'isAssigned': isAssigned,
      'assignedTo': assignedTo,
    };

    final DocumentReference documentReferencer =
        _firestore.collection('equipment').doc();

    await documentReferencer.set(data).whenComplete(() {
      if (kDebugMode) {
        print('equipment added to the database');
      }
    }).catchError((e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    });
  }
}

Future<void> addRequest({
  required String name,
  required String schedule,
  required String purpose,
  required String position,
  required String code,
}) async {
  try {
    final Map<String, dynamic> requestData = {
      'name': name,
      'position': position,
      'schedule': schedule,
      'purpose': purpose,
      'equipmentCode': code,
    };

    await FirebaseFirestore.instance.collection('request').add(requestData);

    if (kDebugMode) {
      print('Request added to Firestore');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error: $e');
    }
  }
}
