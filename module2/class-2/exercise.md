# Linux File Permissions and Ownership Exercises

## 1. Understanding File Permissions

Before performing the exercises, check file permissions using:
```bash
ls -l filename
```

## 2. Changing File Permissions with `chmod`
### Example:
```bash
touch myfile.txt
chmod 644 myfile.txt  # Owner: read/write, Group: read, Others: read
ls -l myfile.txt
```
### Exercise:
- Create a file `testfile.txt`
- Set permissions to allow only the owner to read and write
- Verify permissions using `ls -l`

## 3. Changing Ownership with `chown`
### Example:
```bash
sudo chown user:user myfile.txt  # Change owner to 'user' and group to 'user'
ls -l myfile.txt
```
### Exercise:
- Create a file `ownerfile.txt`
- Change its owner to another user (if applicable)
- Verify ownership using `ls -l`

## 4. Changing Group Ownership with `chgrp`
### Example:
```bash
sudo chgrp developers myfile.txt  # Change group ownership to 'developers'
ls -l myfile.txt
```
### Exercise:
- Create a file `groupfile.txt`
- Change its group ownership to an existing group
- Verify the change using `ls -l`

## 5. Setting Default Permissions with `umask`
### Example:
```bash
umask 027  # Default: owner RW, group R, others no access
```
### Exercise:
- Check the current `umask` value
- Change it so that new files have only owner read/write access
- Create a new file and verify its permissions

## 6. Using Access Control Lists (ACLs) with `setfacl` and `getfacl`
### Example:
```bash
setfacl -m u:john:rwx myfile.txt  # Give user 'john' full permissions
getfacl myfile.txt  # Check ACL settings
```
### Exercise:
- Create a file `aclfile.txt`
- Assign read/write permissions to another user using `setfacl`
- Verify the permissions using `getfacl`
- Remove the ACL entry and confirm it’s removed

### Exercise2:
1. Create a directory `testdir` and set its permissions to allow only the owner to read, write, and execute.
2. Create a file `homework1.txt`, set its permissions to `755`, and verify them.
3. Create a user (if possible) and change the ownership of `homework1.txt` to that user.
4. Create a group `testgroup` and change the group ownership of `homework1.txt` to `testgroup`.
5. Modify `homework1.txt` to remove all permissions for others.
6. Set the default permissions for newly created files to `600` using `umask`.
7. Create a file `aclhomework.txt` and grant `read` access to another user using `setfacl`.
8. Create a directory `acltestdir` and set a default ACL to allow `read/write` for a specific user.
9. Verify and list all ACLs applied to `aclhomework.txt`.
10. Remove all ACL permissions from `aclhomework.txt` and verify it has reverted to standard permissions.
---
