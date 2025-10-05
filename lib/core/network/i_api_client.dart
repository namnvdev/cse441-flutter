abstract class IApiClient{
  Future<T> get<T> (String path,{
            Map<String, dynamic>? query,
            T Function(dynamic data)? fromJson,
          });
 
  Future<T> post<T>(String path,{
            Object? body,
            T Function(dynamic data)? fromJson,
          });

  Future<T> put<T>(String path,{
            Object? body,
            T Function(dynamic data)? fromJson,
          });

  Future<T> delete<T>(String path, {
            T Function(dynamic data)? fromJson,
          });
}