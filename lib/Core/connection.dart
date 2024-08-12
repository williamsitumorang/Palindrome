class Connection {
  static const String apiUrl =
      'https://reqres.in/api/users?page=1&per_page=10'; // URL API

  // Menggabungkan URL API dengan endpoint tertentu
  static String buildUrl(String endpoint) {
    return apiUrl + endpoint;
  }
}
