# Linux Basics Hands-On Quizzes

## Quiz 1: Basic Linux Commands
### Scenario:
You are a junior system administrator, and your manager has assigned you a few tasks to verify and manipulate files and directories.

1. **List all files (including hidden ones) in the `/home/student/documents` directory.**  
   - What command will you use?

2. **Navigate to the `/var/log` directory.**  
   - What command will you use?

3. **Create a directory named `project_backup` inside `/home/student` and then create an empty file named `config.log` inside it.**  
   - Provide the two commands needed.

4. **Copy `config.log` to `/tmp` but retain the original file in `project_backup`.**  
   - What command will you use?

5. **Move `config.log` from `/tmp` back to `/home/student/project_backup` but rename it to `backup.log`.**  
   - What command will you use?

6. **Delete the file `backup.log` from `project_backup` and remove the `project_backup` directory.**  
   - What two commands will you use?

7. **View the first 10 lines of the file `/var/log/syslog`.**  
   - What command will you use?

8. **Display only the last 5 lines of the file `/var/log/messages`.**  
   - What command will you use?

9. **View a large text file named `/var/log/apache2/access.log` page by page.**  
   - What command will you use?

10. **Find all `.txt` files inside `/home/student/documents`.**  
   - What command will you use?

---

## Quiz 2: Linux File Permissions and Ownership
### Scenario:
Your organization has a strict policy on file security, and you are required to manage file permissions carefully.

1. **Set read, write, and execute permissions for the owner and only read and execute for the group and others on a file `/home/student/script.sh` using numeric mode.**  
   - What command will you use?

2. **Give only the owner of `/home/student/private.txt` read and write permissions, and remove all permissions from the group and others using symbolic mode.**  
   - What command will you use?

3. **Set a default permission so that new files created in `/home/student/shared` have read/write permissions for the owner and group, but no permissions for others.**  
   - What command will you use?

4. **Ensure that files in `/home/student/secure` cannot be deleted by anyone except the directory owner, even if others have write access.**  
   - What command will you use?

5. **Grant the user `john` read and execute permissions on the file `/home/student/report.pdf` without changing its ownership.**  
   - What command will you use?

6. **Check the permissions and ACLs of the file `/home/student/report.pdf`.**  
   - What command will you use?

7. **Make the `/usr/local/bin/myscript.sh` executable by all users without changing the owner or group.**  
   - What command will you use?

8. **Set the `setuid` permission on the binary file `/usr/local/bin/custom_program` to allow it to be executed with the owner’s privileges.**  
   - What command will you use?

9. **Set the `setgid` permission on the directory `/home/shared` so that any files created inside inherit the group ownership of the directory.**  
   - What command will you use?

10. **Create a symbolic link for `/var/log/syslog` named `system_log` in your home directory.**  
   - What command will you use?

---

## Quiz 3: Searching and Filtering in Linux
### Scenario:
You are analyzing logs and managing files in a Linux system. You need to efficiently search for information.

1. **Find all `.conf` files inside `/etc` recursively.**  
   - What command will you use?

2. **Search for the word "ERROR" (case-insensitive) in the file `/var/log/syslog`.**  
   - What command will you use?

3. **Find all files modified in the last 2 days inside `/home/student`.**  
   - What command will you use?

4. **Locate all files named `bashrc` on the system.**  
   - What command will you use?

5. **Find all empty files in `/var/tmp`.**  
   - What command will you use?

6. **Search for all lines containing "failed login" in the file `/var/log/auth.log` and display only the matching word.**  
   - What command will you use?

7. **Search for the string "memory error" in all `.log` files inside `/var/log`, including subdirectories.**  
   - What command will you use?

8. **Find all executable files inside `/usr/bin`.**  
   - What command will you use?

9. **Search for lines in `/etc/passwd` that do not start with `#`.**  
   - What command will you use?

10. **Find all directories inside `/home/student` and list them.**  
   - What command will you use?

