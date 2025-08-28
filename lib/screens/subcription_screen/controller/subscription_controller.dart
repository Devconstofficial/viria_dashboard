import 'package:get/get.dart';
import 'package:viria_dashboard/utils/app_strings.dart';

class SubscriptionController extends GetxController {
  final RxList<Map<String, dynamic>> allSubs = <Map<String, dynamic>>[
    {
      "id": "876364",
      "name": "Arrora Gaur",
      "plan": "Basic",
      "date": "12 Dec, 2020",
      "endDate": "12 Dec, 2021",
      "status": "Active",
      "isChecked": false.obs,
    },
    {
      "id": "876365",
      "name": "John Doe",
      "plan": "Premium",
      "date": "01 Jan, 2021",
      "endDate": "01 Jan, 2022",
      "status": "Trial",
      "isChecked": false.obs,
    },
    {
      "id": "876366",
      "name": "Jane Smith",
      "plan": "Pro",
      "date": "15 Feb, 2021",
      "endDate": "15 Feb, 2022",
      "status": "Active",
      "isChecked": false.obs,
    },
    {
      "id": "876367",
      "name": "Robert Brown",
      "plan": "Basic",
      "date": "20 Mar, 2021",
      "endDate": "20 Mar, 2022",
      "status": kExpired,
      "isChecked": false.obs,
    },
    {
      "id": "876368",
      "name": "Emily Davis",
      "plan": "Premium",
      "date": "25 Apr, 2021",
      "endDate": "25 Apr, 2022",
      "status": "Active",
      "isChecked": false.obs,
    },
    {
      "id": "876369",
      "name": "Michael Wilson",
      "plan": "Pro",
      "date": "05 May, 2021",
      "endDate": "05 May, 2022",
      "status": "Active",
      "isChecked": false.obs,
    },
    {
      "id": "876370",
      "name": "Linda Johnson",
      "plan": "Basic",
      "date": "10 Jun, 2021",
      "endDate": "10 Jun, 2022",
      "status": "Trial",
      "isChecked": false.obs,
    },
    {
      "id": "876371",
      "name": "David Martinez",
      "plan": "Premium",
      "date": "15 Jul, 2021",
      "endDate": "15 Jul, 2022",
      "status": "Active",
      "isChecked": false.obs,
    },
    {
      "id": "876372",
      "name": "Sarah Miller",
      "plan": "Pro",
      "date": "22 Aug, 2021",
      "endDate": "22 Aug, 2022",
      "status": kExpired,
      "isChecked": false.obs,
    },
    {
      "id": "876373",
      "name": "Chris Garcia",
      "plan": "Basic",
      "date": "02 Sep, 2021",
      "endDate": "02 Sep, 2022",
      "status": "Active",
      "isChecked": false.obs,
    },
    {
      "id": "876374",
      "name": "Jessica Anderson",
      "plan": "Premium",
      "date": "08 Oct, 2021",
      "endDate": "08 Oct, 2022",
      "status": "Active",
      "isChecked": false.obs,
    },
    {
      "id": "876375",
      "name": "Brian Thomas",
      "plan": "Pro",
      "date": "12 Nov, 2021",
      "endDate": "12 Nov, 2022",
      "status": "Active",
      "isChecked": false.obs,
    },
    {
      "id": "876376",
      "name": "Karen Moore",
      "plan": "Basic",
      "date": "30 Dec, 2021",
      "endDate": "30 Dec, 2022",
      "status": "Active",
      "isChecked": false.obs,
    },
    {
      "id": "876377",
      "name": "Kevin Taylor",
      "plan": "Premium",
      "date": "14 Jan, 2022",
      "endDate": "14 Jan, 2023",
      "status": "Active",
      "isChecked": false.obs,
    },
    {
      "id": "876378",
      "name": "Nancy Lee",
      "plan": "Pro",
      "date": "05 Feb, 2022",
      "endDate": "05 Feb, 2023",
      "status": "Active",
      "isChecked": false.obs,
    },
    {
      "id": "876379",
      "name": "Jason White",
      "plan": "Basic",
      "date": "19 Mar, 2022",
      "endDate": "19 Mar, 2023",
      "status": "Active",
      "isChecked": false.obs,
    },
    {
      "id": "876380",
      "name": "Amy Harris",
      "plan": "Premium",
      "date": "01 Apr, 2022",
      "endDate": "01 Apr, 2023",
      "status": kExpired,
      "isChecked": false.obs,
    },
    {
      "id": "876381",
      "name": "Mark Clark",
      "plan": "Pro",
      "date": "18 May, 2022",
      "endDate": "18 May, 2023",
      "status": "Active",
      "isChecked": false.obs,
    },
    {
      "id": "876382",
      "name": "Rachel Lewis",
      "plan": "Basic",
      "date": "07 Jun, 2022",
      "endDate": "07 Jun, 2023",
      "status": "Active",
      "isChecked": false.obs,
    },
    {
      "id": "876383",
      "name": "George Walker",
      "plan": "Premium",
      "date": "25 Jul, 2022",
      "endDate": "25 Jul, 2023",
      "status": "Active",
      "isChecked": false.obs,
    },
  ].obs;

  var selectedStatus = ''.obs;
  var currentPage2 = 1.obs;
  final int itemsPerPage = 6;
  final int pagesPerGroup = 5;

  int get totalPages => (allSubs.length / itemsPerPage).ceil();

  List get pagedUsers {
    int start = (currentPage2.value - 1) * itemsPerPage;
    int end = start + itemsPerPage;
    return allSubs.sublist(
      start,
      end > allSubs.length ? allSubs.length : end,
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