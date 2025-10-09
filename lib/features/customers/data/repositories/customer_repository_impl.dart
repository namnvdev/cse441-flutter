
import 'package:my_app/features/customers/data/models/customer_model.dart';
import 'package:my_app/features/customers/domain/entities/customer.dart';
import '../../domain/repositories/customer_repository.dart';
import '../data/customer_remote_datasource.dart';

class CustomerRepositoryImpl extends CustomerRepository {
  final CustomerRemoteDataSource remoteDataSource;
  CustomerRepositoryImpl(this.remoteDataSource);
  @override
  Future<void> createCustomer(Customer customer) async {
    CustomerModel customerModel = CustomerModel.fromEntity(customer);
    await remoteDataSource.add(customerModel);
  }
  @override
  Future<void> deleteCustomer(String id) async {
    await remoteDataSource.delete(id);
  }

  @override
  Future<Customer> getCustomer(String id) async {
    CustomerModel? customerModel = await remoteDataSource.getCustomer(id);
    if (customerModel == null) {
      throw Exception('Customer not found');
    }
    return customerModel;
    // return Customer.fromJson(customerModel.toJson());
  }

  @override
  Future<List<Customer>> getCustomers() async {
    List<CustomerModel> customerModels = await remoteDataSource.getAll();
    return customerModels;
    // List<Customer> customers = customerModels.map((e) => Customer.fromJson(e.toJson())).toList();
    // return customers;
  }
  @override
  Future<void> updateCustomer(Customer customer) async {
    await remoteDataSource.update(CustomerModel.fromEntity(customer));

  }
}