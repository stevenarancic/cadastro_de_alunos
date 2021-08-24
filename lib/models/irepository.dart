abstract class IRepository<T> {
  //no futuro, esse método retornara uma lista de objetos T
  Future<List<T>> search();

  Future<T> find(int id);

  Future<int> insert(T entity);

  Future<int> update({
    required T entity,
    required String conditions,
    required String conditionsValue,
  });

  Future<int> remove({
    required String conditions,
    required String conditionsValue,
  });
}