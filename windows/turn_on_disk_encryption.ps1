# enable BitLocker encryption on the C: drive
Enable-BitLocker -MountPoint "C:" -EncryptionMethod "AES256" -UsedSpaceOnly -RecoveryPasswordProtector
