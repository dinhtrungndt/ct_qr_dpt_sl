const String GLOBAL_URL = 'https://ijtechnology.net/assets/images/api/devkit';
//const String GLOBAL_URL = 'http://192.168.0.4/devkit/assets/images/';

const String SERVER_URL = 'https://ijtechnology.net/api_devkit';
//const String SERVER_URL = 'http://192.168.0.4/devkit/api';

const int statusOk = 200;
const int statusCreated = 201;
const int statusAccepted = 202;
const int statusBadRequest = 400;
const int statusNotAuthorized = 403;
const int statusNotFound = 404;
const int statusInternalError = 500;

const String errorOccured = 'Error occured, please try again later';
const String serverURL = 'http://erp.vietgoat.com:853';

const String verifyServerAPI = '$serverURL/hrm/api/server';
const String loginAPI = '$serverURL/erp/Users/weblogin';
const String signUpAPI = 'http://erp.vietgoat.com:854/erp/Users/createHRM';
const String getInfoEmployeeAPI = '$serverURL/hrm/api/employee/infoMobile/';
const String saveInfoEmployeeAPI = '$serverURL/hrm/api/employee/';
const String getListOnLeaveRequestAPI = '$serverURL/hrm/api/onLeaveFileLine';
const String deleteOnLeaveRequestAPI = '$serverURL/hrm/api/onLeaveFileLine/';
const String getListTimekeepingOffsetRequestAPI =
    '$serverURL/hrm/api/TimekeepingOffset';
const String deleteTimekeepingOffsetRequestAPI =
    '$serverURL/hrm/api/TimekeepingOffset/';
const String getListAdvanceRequestAPI = '$serverURL/hrm/api/Reduce/GetAll/';

const String getOnLeaveKindAPI = '$serverURL/hrm/api/permissionType/getAll/';
const String getOnLeaveProfileAPI = '$serverURL/hrm/api/onLeaveFile/';
const String sendOnLeaveRequestAPI = '$serverURL/hrm/api/onLeaveFileLine';

const String getListShiftModelAPI = '$serverURL/hrm/api/shift/';
const String sendShiftAPI = '$serverURL/hrm/api/shift';
const String getListShiftModelByUserAPI =
    '$serverURL/hrm/api/shift/getShiftByDay';
const String sendTimekeepingOffsetRequestAPI =
    '$serverURL/hrm/api/timekeepingOffset';

const String getAdvanceKindAPI = '$serverURL/hrm/api/ReduceList/GetAll/';
const String sendAdvanceRequestAPI = '$serverURL/hrm/api/Reduce/SaveAll/0';

const String getListAttendanceAPI = '$serverURL/hrm/api/attendance/byEmployee/';
const String getListAttendanceInvalidAPI =
    '$serverURL/hrm/api/attendance/invalid/';
const String getTimeSheetsAPI = '$serverURL/hrm/api/workOfDayAnalysis/total';
const String getOffsetAndOnLeaveAPI =
    '$serverURL/hrm/api/workOfDayAnalysis/summaryOffsets';
const String getListSalaryPeriodAPI = '$serverURL/hrm/api/SalaryPeriod/GetAll/';

const String getSalaryCalculateAPI =
    '$serverURL/hrm/api/salarycaculate/GetSalaryByID/';
const String getRegionAPI = '$serverURL/hrm/api/area/';
const String postAddRegionAPI = '$serverURL/hrm/api/area';
const String deleteRegionAPI = '$serverURL/hrm/api/area/';

const String getCompanyAPI = '$serverURL/hrm/api/company/';
const String getBranchAPI = '$serverURL/hrm/api/branch/';
const String postAddBranchAPI = '$serverURL/hrm/api/branch';
const String locationAPI = '$serverURL/hrm/api/location';
const String postCheckInAPI = '$serverURL/hrm/api/attendance/insert/';
const String getScanByDay = '$serverURL/hrm/api/attendance/getScanByDay/';

const String getPositionAPI = '$serverURL/hrm/api/employee/loadChucDanh/';

// Organization
const String getDepartmentAPI = '$serverURL/hrm/api/organization/department/';

// GIVE DECISION DOCTYPE
const String giveDecisionDocTypeAPI =
    '$serverURL/hrm/api/approveProgress/changeStatus';

// ADD WORK PLAN
const String addWorkPlanAPI = '$serverURL/hrm/api/workOfDayPlan/saveOne';

// GET WORK PLAN WITH DATE
const String getWorkPlanWithDateAPI = '$serverURL/hrm/api/workOfDayPlan';

// DELETE WORK PLAN WITH DATE
const String deleteWorkPlanWithDateAPI = '$serverURL/hrm/api/workOfDayPlan/';
