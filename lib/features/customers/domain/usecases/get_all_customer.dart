import '../entities/customer.dart';
import '../repositories/customer_repository.dart';

class GetAllCustomers{
  final CustomerRepository repository;
  GetAllCustomers(this.repository);

  Future<List<Customer>> call() => repository.getCustomers();
}


