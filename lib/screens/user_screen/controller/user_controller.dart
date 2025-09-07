import 'package:get/get.dart';


class UserController extends GetxController {
  final RxList<Map<String, dynamic>> allUsers = <Map<String, dynamic>>[
    {
      "id": "876364",
      "name": "Arrora Gaur",
      "email": "arroragaur@gmail.com",
      "date": "12 Dec, 2020",
      "status": "Active",
      "isChecked": false.obs,
    },
    {
      "id": "876365",
      "name": "John Doe",
      "email": "johndoe@gmail.com",
      "date": "15 Jan, 2021",
      "status": "Inactive",
      "isChecked": false.obs,
    },
    {
      "id": "876366",
      "name": "Jane Smith",
      "email": "janesmith@gmail.com",
      "date": "22 Feb, 2021",
      "status": "Active",
      "isChecked": false.obs,
    },
    {
      "id": "876367",
      "name": "Robert Brown",
      "email": "robertbrown@gmail.com",
      "date": "10 Mar, 2021",
      "status": "Active",
      "isChecked": false.obs,
    },
    {
      "id": "876368",
      "name": "Emily Davis",
      "email": "emilydavis@gmail.com",
      "date": "04 Apr, 2021",
      "status": "Inactive",
      "isChecked": false.obs,
    },
    {
      "id": "876369",
      "name": "Michael Wilson",
      "email": "michaelwilson@gmail.com",
      "date": "09 May, 2021",
      "status": "Active",
      "isChecked": false.obs,
    },
    {
      "id": "876370",
      "name": "Linda Johnson",
      "email": "lindajohnson@gmail.com",
      "date": "14 Jun, 2021",
      "status": "Inactive",
      "isChecked": false.obs,
    },
    {
      "id": "876371",
      "name": "David Martinez",
      "email": "davidmartinez@gmail.com",
      "date": "18 Jul, 2021",
      "status": "Active",
      "isChecked": false.obs,
    },
    {
      "id": "876372",
      "name": "Sarah Miller",
      "email": "sarahmiller@gmail.com",
      "date": "23 Aug, 2021",
      "status": "Inactive",
      "isChecked": false.obs,
    },
    {
      "id": "876373",
      "name": "Chris Garcia",
      "email": "chrisgarcia@gmail.com",
      "date": "02 Sep, 2021",
      "status": "Active",
      "isChecked": false.obs,
    },
    {
      "id": "876374",
      "name": "Jessica Anderson",
      "email": "jessicaanderson@gmail.com",
      "date": "06 Oct, 2021",
      "status": "Active",
      "isChecked": false.obs,
    },
    {
      "id": "876375",
      "name": "Brian Thomas",
      "email": "brianthomas@gmail.com",
      "date": "11 Nov, 2021",
      "status": "Inactive",
      "isChecked": false.obs,
    },
    {
      "id": "876376",
      "name": "Karen Moore",
      "email": "karenmoore@gmail.com",
      "date": "30 Dec, 2021",
      "status": "Active",
      "isChecked": false.obs,
    },
    {
      "id": "876377",
      "name": "Kevin Taylor",
      "email": "kevintaylor@gmail.com",
      "date": "08 Jan, 2022",
      "status": "Inactive",
      "isChecked": false.obs,
    },
    {
      "id": "876378",
      "name": "Nancy Lee",
      "email": "nancylee@gmail.com",
      "date": "14 Feb, 2022",
      "status": "Active",
      "isChecked": false.obs,
    },
    {
      "id": "876379",
      "name": "Jason White",
      "email": "jasonwhite@gmail.com",
      "date": "01 Mar, 2022",
      "status": "Active",
      "isChecked": false.obs,
    },
    {
      "id": "876380",
      "name": "Amy Harris",
      "email": "amyharris@gmail.com",
      "date": "19 Apr, 2022",
      "status": "Inactive",
      "isChecked": false.obs,
    },
    {
      "id": "876381",
      "name": "Mark Clark",
      "email": "markclark@gmail.com",
      "date": "27 May, 2022",
      "status": "Active",
      "isChecked": false.obs,
    },
    {
      "id": "876382",
      "name": "Rachel Lewis",
      "email": "rachellewis@gmail.com",
      "date": "03 Jun, 2022",
      "status": "Inactive",
      "isChecked": false.obs,
    },
    {
      "id": "876383",
      "name": "George Walker",
      "email": "georgewalker@gmail.com",
      "date": "17 Jul, 2022",
      "status": "Active",
      "isChecked": false.obs,
    },
  ].obs;

  var selectedStatus = ''.obs;
  var currentPage2 = 1.obs;
  final int itemsPerPage = 6;
  final int pagesPerGroup = 5;

  int get totalPages => (allUsers.length / itemsPerPage).ceil();

  List get pagedUsers {
    int start = (currentPage2.value - 1) * itemsPerPage;
    int end = start + itemsPerPage;
    return allUsers.sublist(
      start,
      end > allUsers.length ? allUsers.length : end,
    );
  }

  int get currentGroup => ((currentPage2.value - 1) / pagesPerGroup).floor();

  List<int> get visiblePageNumbers {
    int startPage = currentGroup * pagesPerGroup + 1;
    int endPage = (startPage + pagesPerGroup - 1).clamp(1, totalPages);
    return List.generate(endPage - startPage + 1, (index) => startPage + index);
  }

  void goToPage(int page) {
    if (page >= 1 && page <= totalPages) currentPage2.value = page;
  }

  void goToNextPage() {
    if (currentPage2.value < totalPages) {
      currentPage2.value++;
    }
  }

  void goToPreviousPage() {
    if (currentPage2.value > 1) {
      currentPage2.value--;
    }
  }

  void toggleUserSelection(String id) {
    final index = pagedUsers.indexWhere((u) => u['id'] == id);
    if (index != -1) {
      pagedUsers[index]['isChecked'] = !(pagedUsers[index]['isChecked'] ?? false);
      update();
    }
  }

  void toggleSelectAll(bool value) {
    for (var user in pagedUsers) {
      user['isChecked'].value = value;
    }
  }
}