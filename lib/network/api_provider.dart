import 'dart:convert';
import 'package:erp/model/hrm_model/employee_model.dart';
import 'package:erp/model/hrm_model/work_plan_model.dart';
import 'package:erp/model/server_model.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import '../model/hrm_model/advance_model.dart';
import '../model/hrm_model/attendance_model.dart';
import '../model/hrm_model/company_model.dart';
import '../model/hrm_model/on_leave_model.dart';
import '../model/hrm_model/request_management_model.dart';
import '../model/hrm_model/salary_model.dart';
import '../model/hrm_model/shift_model.dart';
import '../model/login_model.dart';
import '../config/hrm_constant.dart';

class ApiProvider {
  late Response response;
  final mapApiKey = 'AIzaSyCQc5-z5GzthnqCu1Ow1zUbndwnxNCF88Y';
  //final mapApiKey = 'AIzaSyA8ak7h0EO5GAIj7EfIzuMHzmHJ1y8g-0Q';
  String connErr = 'Please check your internet connection and try again';

  Future<Response> getConnect(String url, String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      return await get(Uri.parse(url), headers: headers);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Response> postConnect(
      String url, Map<String, dynamic> map, String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final uri = Uri.parse(url);
    var body = jsonEncode(map);
    final encoding = Encoding.getByName('utf-8');
    try {
      return await post(
        uri,
        headers: headers,
        body: body,
        encoding: encoding,
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Response> patchConnect(
      String url, Map<String, dynamic> map, String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final uri = Uri.parse(url);
    var body = jsonEncode(map);
    final encoding = Encoding.getByName('utf-8');
    try {
      return await patch(
        uri,
        headers: headers,
        body: body,
        encoding: encoding,
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Response> postConnect2(String url, String body, String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final uri = Uri.parse(url);
    final encoding = Encoding.getByName('utf-8');
    try {
      return await post(
        uri,
        headers: headers,
        body: body,
        encoding: encoding,
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Response> deleteConnect(String url, String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final uri = Uri.parse(url);
    final encoding = Encoding.getByName('utf-8');
    try {
      return await delete(
        uri,
        headers: headers,
        encoding: encoding,
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<ServerModel?> verifyServer(String url) async {
    var body = {'url': url};
    response = await postConnect(verifyServerAPI, body, '');
    if (response.body != "") {
      ServerModel model = ServerModel.fromJson(jsonDecode(response.body));
      return model;
    } else {
      return null;
    }
  }

  Future<LoginModel?> login(
      String email, String password, String site, String token) async {
    var postData = {'no_': email, 'password': password, 'site': site};
    response = await postConnect(loginAPI, postData, token);
    if (response.statusCode == statusOk) {
      LoginModel model = LoginModel.fromJson(jsonDecode(response.body));
      return model;
    } else {
      return null;
    }
  }

  Future<String> signUp(String name, String no_, String password,
      String saltValue, String code, String attendCode) async {
    var postData1 = {'no_': 'admin', 'password': '111', 'site': 'KIA'};
    var postData = {
      'no_': no_,
      'password': password,
      'name': name,
      'saltValue': saltValue,
      'createdBy': "admin",
      'code': code,
      'attendCode': attendCode,
      'site': 'KIA'
    };
    Response res1 = await postConnect(loginAPI, postData1, "");
    response = await postConnect(signUpAPI, postData,
        LoginModel.fromJson(jsonDecode(res1.body)).accessToken);
    return response.body;
  }

  Future<String> changePassword(String password, String saltValue) async {
    var postData = {
      'no_': User.no_,
      'employeeID': UserModel.id,
      'password': password,
      'status': 1,
      'saltValue': saltValue,
      'createdBy': User.no_,
      'site': User.site
    };
    response = await postConnect(signUpAPI, postData, User.token);
    return response.body;
  }

  // GET INFO EMPLOYEE
  Future<EmployeeModel> getInfoEmployee(int id) async {
    response =
        await getConnect('$getInfoEmployeeAPI$id/${User.site}', User.token);
    if (response.statusCode == statusOk) {
      List model = json.decode(response.body);
      var a = model.map((val) => EmployeeModel.fromMap(val)).toList();
      return a[0];
    } else {
      return null!;
    }
  }

  // SAVE INFO EMPLOYEE
  Future<String> saveInfoEmployee(Map<String, dynamic> data) async {
    response = await patchConnect(
        '$saveInfoEmployeeAPI${UserModel.id}', data, User.token);
    if (response.statusCode == statusOk) {
      return 'OK';
    } else {
      return 'ERROR';
    }
  }

  // GET LIST ONLEAVE KIND
  Future<List<OnLeaveKindModel>> getListOnLeaveKind() async {
    response = await getConnect(getOnLeaveKindAPI + User.site, User.token);
    if (response.statusCode == statusOk) {
      List responseList = json.decode(response.body);
      return responseList.map((val) => OnLeaveKindModel.fromJson(val)).toList();
    } else {
      return [];
    }
  }

  // GET ON LEAVE PROFILE
  Future<OnLeaveProfileModel> getOnLeaveProfile() async {
    response = await getConnect(
        '$getOnLeaveProfileAPI${UserModel.id}/${DateTime.now().year}/${User.site}',
        User.token);
    if (response.statusCode == statusOk) {
      List model = json.decode(response.body);
      var a = model.map((val) => OnLeaveProfileModel.fromMap(val)).toList();
      return a[0];
    } else {
      return null!;
    }
  }

  // GET LIST ONLEAVE
  Future<List<OnLeaveRequestModel>> getListOnLeaveRequest(
      DateTime fromDate, DateTime toDate) async {
    var body = {
          'fromDate': fromDate.toIso8601String(),
          'toDate': toDate.toIso8601String(),
        },
        response = await postConnect(
            '$getListOnLeaveRequestAPI/0/${User.site}', body, User.token);
    if (response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      return responseList
          .map((val) => OnLeaveRequestModel.fromJson(val))
          .toList();
    } else {
      return [];
    }
  }

  // SAVE ONLEAVE
  Future<String> sendOnLeaveRequest(Map<String, dynamic> map) async {
    response = await postConnect(sendOnLeaveRequestAPI, map, User.token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      return response.body;
    } else {
      return '';
    }
  }

  // DELETE ONLEAVE
  Future<String> deleteOnLeaveRequest(int id) async {
    response = await deleteConnect('$deleteOnLeaveRequestAPI$id', User.token);
    if (response.statusCode == statusOk) {
      return 'OK';
    } else {
      return "ERROR";
    }
  }

  // GET LIST TIMEKEEPING OFFSET
  Future<List<TimekeepingOffsetRequestModel>> getListTimekeepingOffsetRequest(
      DateTime fromDate, DateTime toDate) async {
    var body = {
          'fromDate': fromDate.toIso8601String(),
          'toDate': toDate.toIso8601String(),
        },
        response = await postConnect(
            '$getListTimekeepingOffsetRequestAPI/1/${User.site}',
            body,
            User.token);
    if (response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      return responseList
          .map((val) => TimekeepingOffsetRequestModel.fromJson(val))
          .toList();
    } else {
      return [];
    }
  }

  // SAVE TIMEKEEPING OFFSET
  Future<String> sendTimekeepingOffsetRequest(Map<String, dynamic> map) async {
    response =
        await postConnect(sendTimekeepingOffsetRequestAPI, map, User.token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      return response.body;
    } else {
      return '';
    }
  }

  // DELETE TIMEKEEPING OFFSET
  Future<String> deleteTimekeepingOffsetRequest(int id) async {
    response = await deleteConnect(
        '$deleteTimekeepingOffsetRequestAPI$id', User.token);
    if (response.statusCode == statusOk) {
      return 'OK';
    } else {
      return "ERROR";
    }
  }

  Future<List<AdvanceRequestModel>> getListAdvanceRequest(
      int employeeID) async {
    response = await getConnect(
        '$getListAdvanceRequestAPI${User.site}/$employeeID', User.token);
    if (response.statusCode == statusOk) {
      List responseList = json.decode(response.body);
      return responseList
          .map((val) => AdvanceRequestModel.fromJson(val))
          .toList();
    } else {
      return [];
    }
  }

  Future<List<ShiftModel>> getListShiftModel() async {
    response = await getConnect(getListShiftModelAPI + User.site, User.token);
    if (response.statusCode == statusOk) {
      List responseList = json.decode(response.body);
      return responseList.map((val) => ShiftModel.fromMap(val)).toList();
    } else {
      return [];
    }
  }

  Future<String> addShiftModel(Map<String, dynamic> model) async {
    if (model["id"] == null) {
      response = await postConnect(sendShiftAPI, model, User.token);
    } else {
      response =
          await patchConnect('$sendShiftAPI/${model["id"]}', model, User.token);
    }
    return response.body;
  }

  Future<List<ShiftModel>> getListShiftModelByUser(int employeeID) async {
    DateTime now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    var postData = {
      "employeeID": employeeID,
      "date": formattedDate,
      "siteID": User.site
    };

    response =
        await postConnect(getListShiftModelByUserAPI, postData, User.token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      List<ShiftModel> lst =
          responseList.map((f) => ShiftModel.fromMap(f)).toList();
      return lst;
    } else {
      return [];
    }
  }

  Future<List<AdvanceKindModel>> getListAdvanceKind() async {
    response = await getConnect(getAdvanceKindAPI + User.site, User.token);
    if (response.statusCode == statusOk) {
      List responseList = json.decode(response.body);
      return responseList.map((val) => AdvanceKindModel.fromJson(val)).toList();
    } else {
      return [];
    }
  }

  Future<String?> sendAdvanceRequest(Map<String, dynamic> map) async {
    List<dynamic> listData = [];
    listData.add(map);
    response = await postConnect2(
        sendAdvanceRequestAPI, jsonEncode(listData), User.token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      return response.body;
    } else {
      return null;
    }
  }

  Future<List<AttendanceModel>> getListAttendance(
      Map<String, dynamic> map) async {
    response =
        await postConnect(getListAttendanceAPI + User.site, map, User.token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      return responseList.map((val) => AttendanceModel.fromJson(val)).toList();
    } else {
      return [];
    }
  }

  Future<int> getListAttendanceInvalid(Map<String, dynamic> map) async {
    response = await postConnect(
        getListAttendanceInvalidAPI + User.site, map, User.token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      return responseList.length;
    } else {
      return 0;
    }
  }

  Future<List<SalaryPeriodModel>> getListSalaryPeriod() async {
    response = await getConnect(getListSalaryPeriodAPI + User.site, User.token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      return responseList
          .map((val) => SalaryPeriodModel.fromJson(val))
          .toList();
    } else {
      return [];
    }
  }

  Future<List<TimeSheetModel>> getTimeSheets(Map<String, dynamic> map) async {
    response = await postConnect(getTimeSheetsAPI, map, User.token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      return responseList.map((val) => TimeSheetModel.fromJson(val)).toList();
    } else {
      return [];
    }
  }

  Future<List<SummaryOffsetModel>> getOffsetAndOnLeave(
      Map<String, dynamic> map) async {
    response = await postConnect(getOffsetAndOnLeaveAPI, map, User.token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      return responseList
          .map((val) => SummaryOffsetModel.fromJson(val))
          .toList();
    } else {
      return [];
    }
  }

  Future<List<SalaryCalculateModel>> getSalaryCalculate(
      int employeeId, int periodId) async {
    response = await getConnect(
        '$getSalaryCalculateAPI$employeeId/$periodId', User.token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      return responseList
          .map((val) => SalaryCalculateModel.fromJson(val))
          .toList();
    } else {
      return [];
    }
  }

  Future<List<RegionModel>> getRegion() async {
    response = await getConnect('$getRegionAPI${User.site}', User.token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      List<RegionModel> lst =
          responseList.map((f) => RegionModel.fromMap(f)).toList();
      return lst;
    } else {
      return [];
    }
  }

  Future<String> postAddRegion(int id, String name, String description) async {
    var postData;
    if (id == -1) {
      postData = {
        'name': name,
        'description': description,
        'siteID': User.site
      };
    } else {
      postData = {
        'id': id,
        'name': name,
        'description': description,
        'siteID': User.site
      };
    }

    response = await postConnect(postAddRegionAPI, postData, User.token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      return "OK";
    } else {
      return "";
    }
  }

  Future<String> deleteRegion(int id) async {
    response = await deleteConnect('$getRegionAPI$id', User.token);
    if (response.statusCode == statusOk) {
      return "OK";
    } else {
      return "ERROR";
    }
  }

  Future<List<BranchModel>> getBranch() async {
    response = await getConnect('$getBranchAPI${User.site}', User.token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      List<BranchModel> lst =
          responseList.map((f) => BranchModel.fromMap(f)).toList();
      return lst;
    } else {
      return [];
    }
  }

  Future<String> postAddBranch(
      int id, int areaID, String name, String description) async {
    var postData;
    if (id == -1) {
      postData = {
        'areaID': areaID,
        'name': name,
        'description': description,
        'siteID': User.site
      };
    } else {
      postData = {
        'id': id,
        'areaID': areaID,
        'name': name,
        'description': description,
        'siteID': User.site
      };
    }

    response = await postConnect(postAddBranchAPI, postData, User.token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      return "OK";
    } else {
      return "";
    }
  }

  Future<String> deleteBranch(int id) async {
    response = await deleteConnect('$getBranchAPI$id', User.token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      return "OK";
    } else {
      return "";
    }
  }

  // GET LIST DEPARTMENT
  Future<List<OrganizationModel>> getDepartment() async {
    response = await getConnect('$getDepartmentAPI${User.site}', User.token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      List<OrganizationModel> lst =
          responseList.map((f) => OrganizationModel.fromMap(f)).toList();
      return lst;
    } else {
      return [];
    }
  }

  // GET LIST POSITION
  Future<List<PositionModel>> getPosition() async {
    response = await getConnect('$getPositionAPI${User.site}', User.token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      List<PositionModel> lst =
          responseList.map((f) => PositionModel.fromMap(f)).toList();
      return lst;
    } else {
      return [];
    }
  }

  Future<String> postCheckin(int id, String employeeID, String authDate,
      String authTime, int location) async {
    var postData;
    if (id == -1) {
      postData = {
        "employeeID": employeeID,
        "authDate": authDate,
        "authTime": authTime,
        "location": location
      };
    } else {
      postData = {
        'id': id,
        "employeeID": employeeID,
        "authDate": authDate,
        "authTime": authTime,
        "location": location
      };
    }

    response =
        await postConnect(postCheckInAPI + User.site, postData, User.token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      return "OK";
    } else {
      return "";
    }
  }

  Future<List<LocationModel>> getLocation() async {
    response = await getConnect('$locationAPI/${User.site}', User.token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      List<LocationModel> lst =
          responseList.map((f) => LocationModel.fromMap(f)).toList();
      return lst;
    } else {
      return [];
    }
  }

  Future<String> postAddLocation(int id, int branchID, String name,
      String address, String longitude, String latitude, double radius) async {
    var postData;
    if (id == 0) {
      postData = {
        "branchID": branchID,
        "name": name,
        "address": address,
        "longitude": longitude,
        "latitude": latitude,
        "radius": radius,
        "siteID": User.site
      };
    } else {
      postData = {
        "id": id,
        "branchID": branchID,
        "name": name,
        "address": address,
        "longitude": longitude,
        "latitude": latitude,
        "radius": radius,
        "siteID": User.site
      };
    }

    response = await postConnect(locationAPI, postData, User.token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      return "OK";
    } else {
      return "";
    }
  }

  Future<String> deleteLocation(int id) async {
    response = await deleteConnect('$locationAPI/$id', User.token);
    return response.reasonPhrase as String;
  }

  Future<bool> getCheckInStatus() async {
    DateTime now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    var postData = {"employeeID": UserModel.id, "day": formattedDate};

    response =
        await postConnect('$getScanByDay${User.site}', postData, User.token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      if (responseList.length % 2 == 0) {
        return false;
      }
    }
    return true;
  }

  Future<ShiftModel?> getCheckInShift() async {
    await Future.delayed(const Duration(milliseconds: 200), () {});
    return CompanyModel.shiftModel;
  }

  Future<List<PlaceSearchModel>> getAutocomplete(String search) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&components=country:VN&types=address&language=vi&key=$mapApiKey');
    var response = await get(url);
    var json = jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults
        .map((place) => PlaceSearchModel.fromJson(place))
        .toList();
  }

  Future<PlaceModel> getPlace(String placeId) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$mapApiKey');
    var response = await get(url);
    var json = jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String, dynamic>;
    return PlaceModel.fromJson(jsonResult);
  }

  Future<int> getScanByDate(int employeeID) async {
    DateTime now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    var postData = {"employeeID": employeeID, "day": formattedDate};

    response =
        await postConnect('$getScanByDay${User.site}', postData, User.token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      return responseList.length;
    } else {
      return -1;
    }
  }

  // GET COMPANY
  Future<List<Company>> getCompany(String token) async {
    response = await getConnect('$getCompanyAPI${User.site}', token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      List<Company> lst = responseList.map((f) => Company.fromMap(f)).toList();
      return lst;
    } else {
      return [];
    }
  }

  // DECISION DOCTYPE
  Future<String> giveDecisionDocType(
      int docID, String docType, int status) async {
    var postData = {
      "createdBy": User.no_,
      "docType": docType,
      "listDocID": [docID],
      "status": status,
      "siteID": User.site
    };

    response = await postConnect(giveDecisionDocTypeAPI, postData, User.token);
    return response.body;
  }

  // ADD WORK PLAN
  Future<String> addWorkPlan(Map<String, dynamic> data) async {
    response = await postConnect(addWorkPlanAPI, data, User.token);
    return response.body;
  }

  // GET WORK PLAN WITH DATE
  Future<List<WorkPlanModel>> getWorkPlanWithDate(
      Map<String, dynamic> data) async {
    response = await postConnect(
        '$getWorkPlanWithDateAPI/${UserModel.id}/${User.site}',
        data,
        User.token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      List<WorkPlanModel> lst =
          responseList.map((f) => WorkPlanModel.fromMap(f)).toList();
      return lst;
    } else {
      return [];
    }
  }

  // GET WORK PLAN WITH DATE
  Future<String> deleteWorkPlan(DateTime date, int shiftID) async {
    String dStr = date.day < 10 ? '0${date.day}' : date.day.toString();
    String mStr = date.month < 10 ? '0${date.month}' : date.month.toString();
    response = await deleteConnect(
        '$deleteWorkPlanWithDateAPI/${UserModel.id}/$shiftID/${date.year}/c$mStr$dStr',
        User.token);

    return response.body;
  }
}
