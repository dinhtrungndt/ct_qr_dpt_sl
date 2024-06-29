class SalaryCalculateModel {
  final String luongCoBan;
  final String ngayCongChuan;
  final String ngayCongLamViecThucTe;
  final String ngayLe;
  final String ngayCuoi;
  final String ngayNghiTang;
  final String ngayLeCheDo;
  final String ngayNghiPhepNam;
  final String tangCaThuong;
  final String tangCaDem;
  final String tangCaChuNhat;
  final String tangCaNgayle;
  final String luongTheoNgayCong;
  final String luongNgoaiGioThuong;
  final String luongNgoaiGioDem;
  final String luongNgoaiGioNgayLe;
  final String luongNgoaiGioChuNhat;
  final String luongNgoaiGio;
  final String phuCapDocHai;
  final String phuCapNhaO;
  final String phuCapDiLai;
  final String phuCapChuyenCan;
  final String phuCapBocHang;
  final String phuCapComTangCa;
  final String phuCapComTrua;
  final String phuCapComChieu;
  final String phuCapCongTacPhi;
  final String phuCapNhamPu;
  final String phuCapDungMay;
  final String phuCapHoTroKhac;
  final String tongPhuCap;
  final String tongThuNhap;
  final String baoHiem;
  final String congDoan;
  final String nguoiPhuThuoc;
  final String thuNhapChiuThue;
  final String thuNhapTrucTiep;
  final String thueThuNhapCaNhan;
  final String tamUng;
  final String khauTruKhac;
  final String dongPhuc;
  final String theBHYT;
  final String tongKhauTru;
  final String luongThucLinh;
  final String luongThucLinhLamTron;
  SalaryCalculateModel({
    required this.luongCoBan,
    required this.ngayCongChuan,
    required this.ngayCongLamViecThucTe,
    required this.ngayLe,
    required this.ngayCuoi,
    required this.ngayNghiTang,
    required this.ngayLeCheDo,
    required this.ngayNghiPhepNam,
    required this.tangCaThuong,
    required this.tangCaDem,
    required this.tangCaChuNhat,
    required this.tangCaNgayle,
    required this.luongTheoNgayCong,
    required this.luongNgoaiGioThuong,
    required this.luongNgoaiGioDem,
    required this.luongNgoaiGioNgayLe,
    required this.luongNgoaiGioChuNhat,
    required this.luongNgoaiGio,
    required this.phuCapDocHai,
    required this.phuCapNhaO,
    required this.phuCapDiLai,
    required this.phuCapChuyenCan,
    required this.phuCapBocHang,
    required this.phuCapComTangCa,
    required this.phuCapComTrua,
    required this.phuCapComChieu,
    required this.phuCapCongTacPhi,
    required this.phuCapNhamPu,
    required this.phuCapDungMay,
    required this.phuCapHoTroKhac,
    required this.tongPhuCap,
    required this.tongThuNhap,
    required this.baoHiem,
    required this.congDoan,
    required this.nguoiPhuThuoc,
    required this.thuNhapChiuThue,
    required this.thuNhapTrucTiep,
    required this.thueThuNhapCaNhan,
    required this.tamUng,
    required this.khauTruKhac,
    required this.dongPhuc,
    required this.theBHYT,
    required this.tongKhauTru,
    required this.luongThucLinh,
    required this.luongThucLinhLamTron,
  });
  SalaryCalculateModel.fromJson(Map<String, dynamic> json)
      : luongCoBan = json['LƯƠNG CƠ BẢN - LCB'] ?? '',
        ngayCongChuan = json['NGÀY CÔNG CHUẨN - NCC'] ?? '',
        ngayCongLamViecThucTe =
            json['NGÀY CÔNG LÀM VIỆC THỰC TẾ - NCLVTT'] ?? '',
        ngayLe = json['NGÀY LỄ - NPL'] ?? '',
        ngayCuoi = json['NGÀY CƯỚI - NPC'] ?? '',
        ngayNghiTang = json['NGÀY NGHỈ TANG - NNPT'] ?? '',
        ngayNghiPhepNam = json['PHÉP NĂM - PN'] ?? '',
        ngayLeCheDo = json['NC LUẬT ĐỊNH(LỄ+CƯỚI+TANG)'] ?? '',
        tangCaThuong = json['TĂNG CA NGÀY THƯỜNG - TC1'] ?? '',
        tangCaDem = json['TĂNG CA ĐÊM - TC2'] ?? '',
        tangCaChuNhat = json['TĂNG CA CHỦ NHẬT - TC4'] ?? '',
        tangCaNgayle = json['TĂNG CA NGÀY LỄ - TC3'] ?? '',
        luongTheoNgayCong = json['LƯƠNG THEO NGÀY CÔNG'] ?? '',
        luongNgoaiGioThuong = json['LƯƠNG NGOÀI GIỜ THƯỜNG'] ?? '',
        luongNgoaiGioDem = json['LƯƠNG NGOÀI GIỜ ĐÊM'] ?? '',
        luongNgoaiGioNgayLe = json['LƯƠNG NGOÀI GIỜ LỄ'] ?? '',
        luongNgoaiGioChuNhat = json['LƯƠNG NGOÀI GIỜ CHỦ NHẬT'] ?? '',
        luongNgoaiGio = json['LƯƠNG NGOÀI GIỜ'] ?? '',
        phuCapDocHai = json['PHỤ CẤP ĐỘC HẠI'] ?? '',
        phuCapNhaO = json['PHỤ CẤP NHÀ Ở'] ?? '',
        phuCapDiLai = json['PHỤ CẤP ĐI LẠI'] ?? '',
        phuCapChuyenCan = json['PHỤ CẤP CHUYÊN CẦN'] ?? '',
        phuCapBocHang = json['PHỤ CẤP BỐC HÀNG'] ?? '',
        phuCapComTangCa = json['PHỤ CẤP CƠM TĂNG CA'] ?? '',
        phuCapComTrua = json['PHỤ CẤP CƠM TRƯA'] ?? '',
        phuCapComChieu = json['PHỤ CẤP CƠM CHIỀU'] ?? '',
        phuCapCongTacPhi = json['PHỤ CẤP CÔNG TÁC PHÍ'] ?? '',
        phuCapNhamPu = json['PHỤ CẤP NHÁM PU'] ?? '',
        phuCapDungMay = json['PHỤ CẤP ĐỨNG MÁY'] ?? '',
        phuCapHoTroKhac = json['PHỤ CẤP HỖ TRỢ KHÁC'] ?? '',
        tongPhuCap = json['TỔNG PHỤ CẤP'] ?? '',
        tongThuNhap = json['TỔNG THU NHẬP'] ?? '',
        baoHiem = json['BHYT-BHXH-BHTN - BH'] ?? '',
        congDoan = json['CÔNG ĐOÀN CHO NGƯỜI LAO ĐỘNG - CDNLD'] ?? '',
        nguoiPhuThuoc = json['NGƯỜI PHỤ THUỘC'] ?? '',
        thuNhapChiuThue = json['THU NHẬP CHỊU THUẾ'] ?? '',
        thuNhapTrucTiep = json['THU NHẬP TRỰC TIẾP'] ?? '',
        thueThuNhapCaNhan = json['THUẾ THU NHẬP CÁ NHÂN'] ?? '',
        tamUng = json['TẠM ỨNG '] ?? '',
        khauTruKhac = json['TỔNG KHẤU TRỪ KHÁC - TKTK'] ?? '',
        dongPhuc = json['ĐỒNG PHỤC'] ?? '',
        theBHYT = json['THẺ BHYT'] ?? '',
        tongKhauTru = json['TỔNG KHẤU TRỪ - TKT'] ?? '',
        luongThucLinh = json['LƯƠNG THỰC LĨNH'] ?? '',
        luongThucLinhLamTron = json['LƯƠNG THỰC LĨNH (LÀM TRÒN)'] ?? ''
  //
  ;
}
