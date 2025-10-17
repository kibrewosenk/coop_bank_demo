import '../dummy_data/nid_data.dart';
import '../models/nid_model.dart';

class NidService {
  Future<NidModel?> fetchNidData(String nid) async {
    // Dummy fetch
    return dummyNidData[nid];
  }
}