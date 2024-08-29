import 'dart:developer';
import 'dart:io';

import 'package:brightblu_user_info/constant/app_sftp_cred.dart';
import 'package:brightblu_user_info/utils/app_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ssh2/ssh2.dart';

// Note: Logging is retained for production verification; will remove later.
// Note: SFTP credentials are from a constants file; will move to .env for security.

class SftpService {
  static const String host = AppSftpCread.host;
  static const int port = AppSftpCread.port;
  static const String username = AppSftpCread.username;
  static const String password = AppSftpCread.password;

  static Future<String> uploadPdfToSftp(File file, String userName) async {
    final client = SSHClient(
      host: host,
      port: port,
      username: username,
      passwordOrKey: password,
    );

    try {
      final result = await client.connect();
      if (result == "session_connected") {
        final sftp = await client.connectSFTP();
        if (sftp != null) {
          final uploadPath = userName;
          final uploadResult = await client.sftpUpload(
            path: file.path,
            toPath: uploadPath,
            callback: (progress) async {},
          );
          if (uploadResult != null) {
            log('PDF uploaded successfully to $uploadPath');
            return uploadPath;
          } else {
            log('Upload failed');
          }
        } else {
          log('SFTP connection failed');
        }
      } else {
        log('SSH connection failed');
      }
    } catch (e) {
      log('Error: $e');
    } finally {
      try {
        await client.disconnect();
      } catch (e) {
        log('Failed to disconnect: ${e.toString()}');
      }
    }
    return '';
  }

  static Future<bool> removeDirectoryFromSftp(String userName) async {
    final client = SSHClient(
      host: host,
      port: port,
      username: username,
      passwordOrKey: password,
    );

    try {
      final result = await client.connect();
      if (result == "session_connected") {
        final sftp = await client.connectSFTP();
        if (sftp != null) {
          final directoryPath = userName;
          final contents = await client.sftpLs(directoryPath);
          // Delete all files in the directory
          for (var item in contents!) {
            if (!item['isDirectory']) {
              final filePath = '$directoryPath/${item['filename']}';
              await client.sftpRm(filePath);
              return true;
            } else {
              AppUtils.showToast("File not found");
            }
          }

          // Attempt to remove the directory after deleting all files
          final removalResult = await client.sftpRmdir(directoryPath);
          log('Directory $removalResult removed successfully');
          // Disconnect from SFTP client
          await client.disconnectSFTP();
        } else {
          log('SFTP connection failed');
        }
      } else {
        log('SSH connection failed');
      }
    } catch (e) {
      log('Error: $e');
    } finally {
      try {
        await client.disconnect();
      } catch (e) {
        log('Failed to disconnect: ${e.toString()}');
      }
    }
    return false;
  }

  static Future<String?> downloadFileFromSftp(
      String userName, String fileName) async {
    final client = SSHClient(
      host: host,
      port: port,
      username: username,
      passwordOrKey: password,
    );

    String? localPath;

    try {
      final result = await client.connect();
      if (result == "session_connected") {
        final sftp = await client.connectSFTP();
        if (sftp != null) {
          // Get local directory path
          final tempDir = await getTemporaryDirectory();
          localPath = '${tempDir.path}/$fileName';
          final remoteFilePath = '$userName/$fileName';
          final downloadResult = await client.sftpDownload(
            path: remoteFilePath,
            toPath: localPath,
            callback: (progress) async {
              log('Download progress: $progress%');
            },
          );

          if (downloadResult != null) {
            log('File downloaded successfully to $localPath');
          } else {
            log('Download failed');
            localPath = null;
          }
        } else {
          log('SFTP connection failed');
        }
      } else {
        log('SSH connection failed');
      }
    } catch (e) {
      log('Error: $e');
      localPath = null;
    } finally {
      try {
        await client.disconnect();
      } catch (e) {
        log('Failed to disconnect: ${e.toString()}');
      }
    }
    return localPath;
  }
}
