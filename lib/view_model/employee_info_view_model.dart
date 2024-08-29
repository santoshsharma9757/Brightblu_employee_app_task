import 'dart:developer';
import 'dart:io';

import 'package:brightblu_user_info/core/di.dart';
import 'package:brightblu_user_info/models/user_model.dart';
import 'package:brightblu_user_info/repositories/user_repository/user_repository.dart';
import 'package:brightblu_user_info/services/pdf_generations_services/pdf_generation_services.dart';
import 'package:brightblu_user_info/services/sftp_services/sftp_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class EmployeeInfoViewModel extends ChangeNotifier {
  final UserRepository _userRepository = GetIt.instance<UserRepository>();
  final PdfGenerationService _pdfService = getIt<PdfGenerationService>();
  final SftpService sftpServices = SftpService();

//Text Edition
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final ageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  //Gender
  String _selectedGender = 'Male';
  get selectedGender => _selectedGender;
  final List<String> _gender = ['Male', 'Female', 'Other'];
  List<String> get gender => _gender;
  setGender(String value) {
    _selectedGender = value;
    notifyListeners();
  }

//Empoyment
  String _selectedEmploymentStatus = 'Employed';
  String get selectedEmploymentStatus => _selectedEmploymentStatus;

  List<String> employementStatus = ['Employed', 'Unemployed', 'Student'];
  List<String> get getEmployementStatus => employementStatus;
  setEmployementStatus(String employementStatus) {
    _selectedEmploymentStatus = employementStatus;
    notifyListeners();
  }

//DOB
  DateTime? _datepicker;
  String? _selectedDate;
  String? get selectedDate => _selectedDate;

  setDob(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      _datepicker = pickedDate;
      String formattedDate = DateFormat('yyyy-MM-dd').format(_datepicker!);
      _selectedDate = formattedDate;
    }
    notifyListeners();
  }

  //Generate pdf
  bool _isPdfGenerated = false;
  get isPdfGenerated => _isPdfGenerated;
  setIsPdfGenerated(value) {
    _isPdfGenerated = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  File? file;
  Future<File> generatePersonalInfoPdf() async {
    setIsLoading(true);
    file = await _pdfService.generatePersonalInfoPdf(
      name: nameController.text,
      age: int.parse(ageController.text),
      email: emailController.text,
      address: addressController.text,
      dob: selectedDate.toString(),
      gender: selectedGender,
      employmentStatus: selectedEmploymentStatus,
    );
    if (file != null) {
      setIsLoading(false);
    }
    return file!;
  }

  bool _isPDFUploading = false;
  bool get isPDFUploading => _isPDFUploading;

  setIsPDFUploading(bool value) {
    _isPDFUploading = value;
    notifyListeners();
  }

  //Create user

  Future<bool> saveEmpoyeData({String? employeeId, String? empName}) async {
    setIsPDFUploading(true);

    try {
      final userInfo = UserInfo(
        id: employeeId,
        name: nameController.text,
        age: int.tryParse(ageController.text),
        email: emailController.text,
        address: addressController.text,
        dob: _selectedDate,
        gender: _selectedGender,
        employmentStatus: _selectedEmploymentStatus,
      );
      if (employeeId == null) {
        final newUserId = await _userRepository.createUser(userInfo);
        String emName = nameController.text;
        clearEnteredValue();
        final updatedUserInfo = userInfo.copyWith(id: newUserId);
        log("userId $updatedUserInfo");
        await SftpService.uploadPdfToSftp(file!, emName);
        setIsPdfGenerated(false);
      } else {
        await SftpService.removeDirectoryFromSftp(empName!);
        await _userRepository.updateUser(userInfo);
        clearEnteredValue();
        await SftpService.uploadPdfToSftp(file!, empName.toString());
        setIsPdfGenerated(false);
      }

      return true;
    } catch (e) {
      return false;
    } finally {
      setIsPDFUploading(false);
    }
  }

//Initialize data
  Future<void> fetchAndSetEmployeeInfo(String employeeId) async {
    UserInfo? userInfo = await _userRepository.readUser(employeeId);
    if (userInfo != null) {
      nameController.text = userInfo.name ?? '';
      emailController.text = userInfo.email ?? '';
      ageController.text = userInfo.age?.toString() ?? '';
      addressController.text = userInfo.address ?? '';
      setGender(userInfo.gender.toString());
      setEmployementStatus(userInfo.employmentStatus.toString());
      if (userInfo.dob != null) {
        DateTime parsedDate = DateTime.parse(userInfo.dob.toString());
        String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
        _selectedDate = formattedDate;
      } else {
        _selectedDate = null;
      }

      notifyListeners();
    }
  }

//Delete user
  Future<bool> deleteEmployee(String employeeId, String employeeName) async {
    try {
      bool isRemoved = await SftpService.removeDirectoryFromSftp(employeeName);
      if (isRemoved) {
        await _userRepository.deleteUser(employeeId);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  bool _ispdfDownloading = false;
  get ispdfDownloading => _ispdfDownloading;
  setIspdfDownloading(value) {
    _ispdfDownloading = value;
    notifyListeners();
  }

  //Delete user
  Future<String?> downloadPdf(String employeeName) async {
    setIspdfDownloading(true);
    try {
      var path = await SftpService.downloadFileFromSftp(
          employeeName, "employee_info.pdf");
      setIspdfDownloading(false);
      if (path != null) {
        return path;
      } else {
        return null;
      }
    } catch (e) {
      setIspdfDownloading(false);
      return null;
    }
  }

  //Clear Entered value
  clearEnteredValue() {
    nameController.text = '';
    emailController.text = '';
    ageController.text = '';
    addressController.text = '';
    setGender(_gender.first);
    setEmployementStatus(employementStatus.first);
    _selectedDate = null;
  }
}
