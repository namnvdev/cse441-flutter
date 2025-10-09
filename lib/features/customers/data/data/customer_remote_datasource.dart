// customer_remote_data_source.dart
import '../../../../core/data/firebase_remote_data_source.dart';
import '../models/customer_model.dart';

abstract class CustomerRemoteDataSource {
  Future<List<CustomerModel>> getAll();
  Future<CustomerModel?> getCustomer(String id);
  Future<void> add(CustomerModel customer);
  Future<void> update(CustomerModel customer);
  Future<void> delete(String id);
}

class CustomerRemoteDataSourceImpl implements CustomerRemoteDataSource {
//  final _collection = FirebaseFirestore.instance.collection('customers');
  // final _remoteSource  = FirebaseRemoteDataSource<CustomerModel>(
  //   collectionName: 'customers',
  //   fromFirestore: (doc) => CustomerModel.fromFirestore(doc),
  //   toFirestore: (model) => model.toJson(),
  //   );
  final FirebaseRemoteDS<CustomerModel> _remoteSource;



//  final _customerCollection = FirebaseFirestore.instance.collection("customers");

  CustomerRemoteDataSourceImpl()
      : _remoteSource = FirebaseRemoteDS<CustomerModel>(
          collectionName: 'customers',
          fromFirestore: (doc) => CustomerModel.fromFirestore(doc),
          toFirestore: (model) => model.toJson(),
        );


  @override
  Future<List<CustomerModel>> getAll() async {
    List<CustomerModel> customers = [];
    customers = await _remoteSource.getAll();
    return customers;
  }

  @override
  Future<CustomerModel?> getCustomer(String id) async {
    CustomerModel? customer = await _remoteSource.getById(id);
    return customer;
  }

  @override
  Future<void> add(CustomerModel customer) async {
    await _remoteSource.add(customer);
  }

  @override
  Future<void> update(CustomerModel customer) async {
    await _remoteSource.update(customer.id.toString(), customer);
  }

  @override
  Future<void> delete(String id) async {
    await _remoteSource.delete(id);
  }
}
