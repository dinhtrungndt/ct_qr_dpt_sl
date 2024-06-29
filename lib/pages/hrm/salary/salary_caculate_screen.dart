import 'package:erp/base/widget/loading.dart';
import 'package:erp/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../method/hrm_method.dart';
import 'bloc/salary_calculate_bloc.dart';
import 'choose_salary_period_caculate_screen.dart';

class SalaryCalculateScreen extends StatefulWidget {
  const SalaryCalculateScreen({Key? key}) : super(key: key);

  @override
  State<SalaryCalculateScreen> createState() => _SalaryCalculateScreenState();
}

class _SalaryCalculateScreenState extends State<SalaryCalculateScreen> {
  @override
  void initState() {
    //timekeepingBloc = BlocProvider.of<TimekeepingBloc>(context);
    BlocProvider.of<SalaryCalculateBloc>(context)
        .add(InitialSalaryCalculateEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, //const Color.fromRGBO(243, 246, 255, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Phiếu lương',
          style: TextStyle(color: blueBlack),
        ),
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 0,
      ),
      body: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          //width: 180,
          alignment: Alignment.center,
          child: BlocBuilder<SalaryCalculateBloc, SalaryCalculateState>(
            builder: (context, state) {
              return InkWell(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChooseSalaryPeriodCalculateScreen(
                            listSalaryPeriodModel:
                                state.listSalaryPeriodModel)),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                        child: Text(
                            (state.salaryPeriodModel != null)
                                ? 'Tháng ${state.salaryPeriodModel?.month} - ${state.salaryPeriodModel?.year} (Kỳ ${state.salaryPeriodModel?.termInAMonth == 1 ? 'lương ứng' : 'lương chính'})'
                                : 'Chọn kỳ lương',
                            style: const TextStyle(
                                color: blueGrey1, fontSize: 16))),
                    const Icon(Icons.arrow_drop_down,
                        color: blueGrey2, size: 30),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Expanded(child: BlocBuilder<SalaryCalculateBloc, SalaryCalculateState>(
            builder: (context, state) {
          if (state.status == SalaryCalculateStatus.loading) {
            return const Loading();
          } else if (state.status == SalaryCalculateStatus.success) {
            return state.salaryCalculateModel == null
                ? const SizedBox.shrink()
                : SingleChildScrollView(
                    child: Column(children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        color: const Color.fromRGBO(243, 246, 255, 1),
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Lương cơ bản',
                              style: TextStyle(fontSize: 16, color: blueBlack),
                            ),
                            Text(
                              convertNumber(
                                  state.salaryCalculateModel!.luongCoBan),
                              style: const TextStyle(
                                  fontSize: 16, color: blueBlack),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 30,
                        padding: const EdgeInsets.only(left: 10),
                        color: mainColor.withOpacity(0.2),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'TIỀN LƯƠNG',
                          style: TextStyle(color: blueBlack.withOpacity(0.7)),
                        ),
                      ),
                      // _buildSalaryItem(
                      //     'Ngày công chuẩn',
                      //     convertNumber(
                      //         state.salaryCaculateModel!.ngayCongChuan)),
                      // _buildSalaryItem(
                      //     'Ngày công thường',
                      //     convertNumber(state
                      //         .salaryCaculateModel!.ngayCongLamViecThucTe)),
                      _buildSalaryItem(
                          'Ngày công thường',
                          convertNumber(state
                              .salaryCalculateModel!.ngayCongLamViecThucTe),
                          convertNumber(
                              state.salaryCalculateModel!.luongTheoNgayCong,
                              isInt: true)),
                      _buildSalaryItem(
                          'Ngày lễ/chế độ',
                          convertNumber(
                              state.salaryCalculateModel!.ngayLeCheDo),
                          ''),
                      // _buildSalaryItem('Ngày lễ',
                      //     convertNumber(state.salaryCaculateModel!.ngayLe)),
                      // _buildSalaryItem('Ngày nghỉ cưới',
                      //     convertNumber(state.salaryCaculateModel!.ngayCuoi)),
                      // _buildSalaryItem(
                      //     'Ngày nghỉ tang',
                      //     convertNumber(
                      //         state.salaryCaculateModel!.ngayNghiTang)),
                      _buildSalaryItem(
                          'Ngày nghỉ phép năm',
                          convertNumber(
                              state.salaryCalculateModel!.ngayNghiPhepNam),
                          ''),
                      _buildSalaryItem(
                          'Tăng ca ngày thường',
                          convertNumber(
                              state.salaryCalculateModel!.tangCaThuong),
                          convertNumber(
                              state.salaryCalculateModel!.luongNgoaiGioThuong,
                              isInt: true)),
                      _buildSalaryItem(
                          'Tăng ca đêm',
                          convertNumber(state.salaryCalculateModel!.tangCaDem),
                          convertNumber(
                              state.salaryCalculateModel!.luongNgoaiGioDem,
                              isInt: true)),
                      _buildSalaryItem(
                          'Tăng ca ngày lễ',
                          convertNumber(
                              state.salaryCalculateModel!.tangCaNgayle),
                          convertNumber(
                              state.salaryCalculateModel!.luongNgoaiGioNgayLe,
                              isInt: true)),
                      _buildSalaryItem(
                          'Tăng ca chủ nhật',
                          convertNumber(
                              state.salaryCalculateModel!.tangCaChuNhat),
                          convertNumber(
                              state.salaryCalculateModel!.luongNgoaiGioChuNhat,
                              isInt: true)),

                      //_buildSalaryItem('Lương nghỉ dịch', '-'),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 30,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tổng lương [1]',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.deepOrange[900])),
                              Text(
                                  sumNumber(
                                      state.salaryCalculateModel!
                                          .luongTheoNgayCong,
                                      state
                                          .salaryCalculateModel!.luongNgoaiGio),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.deepOrange[900])),
                            ]),
                      ),
                      Container(
                        height: 30,
                        padding: const EdgeInsets.only(left: 10),
                        color: mainColor.withOpacity(0.2),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'PHỤ CẤP',
                          style: TextStyle(color: blueBlack.withOpacity(0.7)),
                        ),
                      ),
                      _buildAllowanceItem(
                          'Phụ cấp độc hại',
                          convertNumber(
                              state.salaryCalculateModel!.phuCapDocHai)),
                      _buildAllowanceItem(
                          'Phụ cấp nhà ở',
                          convertNumber(
                              state.salaryCalculateModel!.phuCapNhaO)),
                      _buildAllowanceItem(
                          'Phụ cấp đi lại',
                          convertNumber(
                              state.salaryCalculateModel!.phuCapDiLai)),
                      _buildAllowanceItem(
                          'Phụ cấp cơm tăng ca',
                          convertNumber(
                              state.salaryCalculateModel!.phuCapComTangCa)),
                      _buildAllowanceItem(
                          'Phụ cấp chuyên cần',
                          convertNumber(
                              state.salaryCalculateModel!.phuCapChuyenCan)),
                      _buildAllowanceItem(
                          'Phụ cấp bốc hàng',
                          convertNumber(
                              state.salaryCalculateModel!.phuCapBocHang)),
                      _buildAllowanceItem(
                          'Phụ cấp công tác phí',
                          convertNumber(
                              state.salaryCalculateModel!.phuCapCongTacPhi)),

                      _buildAllowanceItem(
                          'Phụ cấp cơm trưa',
                          convertNumber(
                              state.salaryCalculateModel!.phuCapComTrua)),
                      _buildAllowanceItem(
                          'Phụ cấp cơm chiều',
                          convertNumber(
                              state.salaryCalculateModel!.phuCapComChieu)),
                      _buildAllowanceItem(
                          'Phụ cấp nhám pu',
                          convertNumber(
                              state.salaryCalculateModel!.phuCapNhamPu)),
                      _buildAllowanceItem(
                          'Phụ cấp đứng máy',
                          convertNumber(
                              state.salaryCalculateModel!.phuCapDungMay)),
                      _buildAllowanceItem(
                          'Phụ cấp hỗ trợ khác',
                          convertNumber(
                              state.salaryCalculateModel!.phuCapHoTroKhac)),
                      // _buildAllowanceItem('Thưởng', '-'),
                      // _buildAllowanceItem('Tổng phụ cấp',
                      //     state.salaryCalculateModel!.tongPhuCap),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 30,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tổng phụ cấp [2]',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.deepOrange[900])),
                              Text(
                                  convertNumber(
                                      state.salaryCalculateModel!.tongPhuCap),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.deepOrange[900])),
                            ]),
                      ),
                      Container(
                        color: Colors.lightBlue[200],
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 30,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tổng thu nhập:A=[1]+[2]',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 16,
                                      color: Colors.indigo[700])),
                              Text(
                                  convertNumber(
                                      state.salaryCalculateModel!.tongThuNhap,
                                      isInt: true),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.indigo[700])),
                            ]),
                      ),
                      Container(
                        height: 30,
                        padding: const EdgeInsets.only(left: 10),
                        color: mainColor.withOpacity(0.2),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'KHOẢN TRỪ',
                          style: TextStyle(color: blueBlack.withOpacity(0.7)),
                        ),
                      ),
                      _buildAllowanceItem('Tạm ứng',
                          convertNumber(state.salaryCalculateModel!.tamUng)),
                      _buildAllowanceItem('Tiền BHXH+BHYT',
                          convertNumber(state.salaryCalculateModel!.baoHiem)),
                      _buildAllowanceItem(
                          'Thuế TNCN',
                          convertNumber(convertNumber(
                              state.salaryCalculateModel!.thueThuNhapCaNhan))),
                      _buildAllowanceItem('Công đoàn',
                          convertNumber(state.salaryCalculateModel!.congDoan)),
                      _buildAllowanceItem(
                          'Khấu trừ khác',
                          convertNumber(
                              state.salaryCalculateModel!.khauTruKhac)),
                      Container(
                        color: Colors.lightBlue[200],
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 30,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tổng các khoản khấu trừ [B]',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 16,
                                      color: Colors.red[800])),
                              Text(
                                  convertNumber(
                                      state.salaryCalculateModel!.tongKhauTru),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.red[800])),
                            ]),
                      ),
                      Container(
                        color: Colors.purple[100],
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 40,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Thực lãnh [C]=[A]-[B]:',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 17,
                                      color: Colors.purple[900])),
                              Text(
                                  convertNumber(
                                      state.salaryCalculateModel!.luongThucLinh,
                                      isInt: true),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.purple[900])),
                            ]),
                      ),
                      Container(
                        color: Colors.purple[100],
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 40,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Thực lãnh làm tròn:',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 17,
                                      color: Colors.purple[900])),
                              Text(
                                  convertNumber(
                                      state.salaryCalculateModel!
                                          .luongThucLinhLamTron,
                                      isInt: true),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.purple[900])),
                            ]),
                      ),
                    ]),
                  );
          }
          return const SizedBox.shrink();
        })),
      ]),
    );
  }
}

Widget _buildSalaryItem(String name, String date, String money) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    height: 30,
    child: Row(children: [
      SizedBox(width: 200, child: Text(name, overflow: TextOverflow.ellipsis)),
      Expanded(child: Text(date)),
      Text(money),
    ]),
  );
}

Widget _buildAllowanceItem(String name, String money) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 10),
    height: 30,
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(name),
      Text(money),
    ]),
  );
}
