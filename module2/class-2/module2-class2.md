
# 1. `Linux File Permissions`

Linux file permissions determine who can read, write, or execute files and directories. They are essential for system security and proper file sharing among users.

---

## File Permission Components

Each file or directory in Linux has three types of permissions:
1. **Read (r)**: Allows viewing the file content or listing directory contents.
2. **Write (w)**: Allows modifying the file or creating/deleting files within a directory.
3. **Execute (x)**: Allows executing a file or accessing a directory.

Permissions are grouped into three categories:
- **User (u)**: The owner of the file.
- **Group (g)**: Users in the file's group.
- **Others (o)**: Everyone else.

---

## Viewing Permissions

Use the `ls -l` command to display permissions for files and directories:
```bash
ls -l
```

Example output:
```
-rwxr-xr-- 1 user group 1024 Dec 28 12:00 example.sh
```
- `rwxr-xr--` indicates the permissions.
- `rwx` (user): Read, write, execute.
- `r-x` (group): Read, execute.
- `r--` (others): Read.

---

## Changing Permissions

Use the `chmod` command to change permissions.

### Symbolic Mode
Modify permissions using symbols like `u`, `g`, `o`, and `a` (all):
```bash
chmod u+x example.sh
```
This adds execute (`x`) permission for the user.

### Numeric Mode
Specify permissions with a three-digit number:
- `4`: Read
- `2`: Write
- `1`: Execute

Example:
```bash
chmod 754 example.sh
```
This sets:
- `7` (user): Read, write, execute.
- `5` (group): Read, execute.
- `4` (others): Read.

---

## Examples

### Example 1: Grant Execute Permission to User
```bash
chmod u+x script.sh
```
- Adds execute permission for the user.
- Result: `-rwxr--r--`

### Example 2: Remove Write Permission from Group
```bash
chmod g-w file.txt
```
- Removes write permission for the group.
- Result: `-rw-r--r--`

### Example 3: Set Permissions for All
```bash
chmod a+r file.txt
```
- Adds read permission for everyone.
- Result: `-rw-r--r--`

### Example 4: Set Specific Permissions Using Numeric Mode
```bash
chmod 644 document.txt
```
- User: Read, write.
- Group, others: Read only.
- Result: `-rw-r--r--`

---

# 2. `Special Permissions`

### SetUID
Allows a file to run with the permissions of its owner:
```bash
chmod u+s program
```

### SetGID
Allows files in a directory to inherit the group of the directory:
```bash
chmod g+s directory
```

### Sticky Bit
Prevents users from deleting files they don’t own in a shared directory:
```bash
chmod +t directory
```

---

## Summary Table

| Symbol | Numeric | Permission | Description                  |
|--------|---------|------------|------------------------------|
| `r`    | `4`     | Read       | View file content or list directory |
| `w`    | `2`     | Write      | Modify file or directory     |
| `x`    | `1`     | Execute    | Run file or access directory |

Understanding and managing Linux file permissions effectively helps maintain security and control over your system.

# 3. `Changing Ownership`

Use `chown` to change file user ownership:
```bash
chown new_user:new_group file.txt
```


Use `chgrp` to change file group ownership:
```bash
chgrp new_group file.txt
```

---

# 4. `umask`

In Linux, the `umask` (user file-creation mode mask) is a mechanism that determines the default permissions for newly created files and directories. It acts as a filter that removes permissions from the system's default settings.

## Default Permissions

When a file or directory is created, it is assigned default permissions. These defaults are:
- Files: `666` (read and write for all)
- Directories: `777` (read, write, and execute for all)

The `umask` subtracts specific permissions from these defaults to calculate the actual permissions.

---

## Viewing the Current `umask`

To view the current `umask` value, use:
```bash
umask
```

# 5. `setfacl` and `getfacl` Commands

The `setfacl` and `getfacl` commands in Linux are used to manage Access Control Lists (ACLs). ACLs allow fine-grained control over file and directory permissions beyond the standard owner-group-others model.

---

## What is ACL?

Access Control Lists (ACLs) provide a way to grant permissions to specific users or groups for files and directories. This is useful when multiple users require different levels of access to the same file or directory.

---

## `setfacl` Command

The `setfacl` command sets ACLs for files or directories.

### Syntax
```bash
setfacl [options] {action} file
```

### Common Options
- `-m`: Modify or add a specific ACL.
- `-x`: Remove a specific ACL.
- `-b`: Remove all ACL entries.
- `-R`: Apply recursively to directories.

### Example 1: Grant Read Permission to a User
```bash
setfacl -m u:john:r file.txt
```
- Grants read (`r`) permission to the user `john` for `file.txt`.

### Example 2: Grant Read and Write Permissions to a Group
```bash
setfacl -m g:developers:rw file.txt
```
- Grants read and write (`rw`) permissions to the group `developers` for `file.txt`.

### Example 3: Apply Permissions Recursively
```bash
setfacl -R -m u:jane:rw /data
```
- Grants read and write permissions to the user `jane` for the `/data` directory and its contents.

### Example 4: Remove a Specific ACL
```bash
setfacl -x u:john file.txt
```
- Removes the ACL for the user `john` on `file.txt`.

---

## `getfacl` Command

The `getfacl` command retrieves and displays ACLs for files and directories.

### Syntax
```bash
getfacl [file/directory]
```

### Example 1: View ACL for a File
```bash
getfacl file.txt
```
Output:
```
# file: file.txt
# owner: user1
# group: group1
user::rw-
user:john:r--
group::r--
mask::r--
other::r--
```

### Example 2: View ACL for a Directory
```bash
getfacl /data
```
Output:
```
# file: /data
# owner: user1
# group: group1
user::rwx
group::r-x
other::r--
default:user::rwx
default:group::r-x
default:other::r--
```

---

## Important Points

1. **Default ACL**: Default ACLs apply to new files or directories created within a directory.
   ```bash
   setfacl -m d:u:jane:rwx /data
   ```

2. **Mask**: The mask defines the maximum permissions that can be granted to users or groups other than the owner.

3. **Removing All ACLs**:
   ```bash
   setfacl -b file.txt
   ```

---

## Summary Table

| Command                       | Description                                     |
|-------------------------------|-------------------------------------------------|
| `setfacl -m u:user:permission` | Add or modify an ACL for a user.               |
| `setfacl -m g:group:permission` | Add or modify an ACL for a group.             |
| `setfacl -x u:user`            | Remove a specific ACL for a user.              |
| `setfacl -R -m u:user:permission` | Apply ACL recursively to a directory.       |
| `getfacl file`                | Display the ACLs for a file or directory.      |
| `setfacl -b file`             | Remove all ACLs from a file or directory.      |

# 6. `Vim Editor`

Vim is a powerful text editor commonly used for programming and editing configuration files. Below is a comprehensive guide to essential Vim commands, examples, and options.

## Opening and Closing Files

### Commands
- `vim filename` 
  - Opens a file in Vim.
- `:q` 
  - Quits Vim (only works if no changes are made).
- `:q!`
  - Quits Vim without saving changes.
- `:w`
  - Saves the file.
- `:wq` or `:x`
  - Saves the file and exits Vim.

## Editing

### Commands
- `i`
  - Enters insert mode before the cursor.
- `a`
  - Enters insert mode after the cursor.
- `o`
  - Opens a new line below the current line and enters insert mode.
- `O`
  - Opens a new line above the current line and enters insert mode.
- `r`
  - Replaces a single character under the cursor.
- `dd`
  - Deletes the current line.
- `yy`
  - Copies (yanks) the current line.
- `p`
  - Pastes the copied or deleted text below the cursor.
- `P`
  - Pastes the copied or deleted text above the cursor.
- `u`
  - Undoes the last change.
- `Ctrl-r`
  - Redoes the last undone change.
