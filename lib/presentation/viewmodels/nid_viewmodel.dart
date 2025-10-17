// Updated lib/presentation/viewmodels/nid_viewmodel.dart
import 'package:flutter/material.dart';
import '../../data/models/nid_model.dart';
import '../../data/services/nid_service.dart';

class NidViewModel extends ChangeNotifier {
  final NidService _nidService = NidService();
  NidModel? nidData;
  String? currentNid;

  Future<NidModel?> fetchNidData(String nid) async {
    currentNid = nid;
    nidData = await _nidService.fetchNidData(nid);
    notifyListeners();
    return nidData;
  }
}