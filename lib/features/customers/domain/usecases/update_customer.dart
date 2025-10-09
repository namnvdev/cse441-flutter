import 'package:my_app/features/customers/domain/entities/customer.dart';
import 'package:my_app/features/customers/domain/repositories/customer_repository.dart';

class UpdateCustomer {
  final CustomerRepository repository;

  UpdateCustomer(this.repository);

  Future<void> call(Customer customer) async {
    await repository.updateCustomer(customer);
  }

}