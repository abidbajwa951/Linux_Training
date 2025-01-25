# Understanding SELinux Commands: `chcon`, `restorecon`, and `semanage fcontext`

SELinux (Security-Enhanced Linux) enhances security by controlling access to resources. This guide covers key SELinux commands: `chcon`, `restorecon`, and `semanage fcontext`.

---

## 1. `chcon` (Change Context)

### Usage:
`chcon` temporarily changes a file's SELinux context. Changes are non-persistent.

### Common Options:
- `-t`: Change type.
- `-u`: Change user.
- `-r`: Change role.
- `-l`: Change level.
- `--reference`: Use context of a reference file.

### Example:
```bash
sudo chcon -t httpd_sys_content_t /var/www/html/index.html
ls -Z /var/www/html/index.html
```
---

## 2. `restorecon` (Restore Context)

### Usage:
Restores a file or directory's SELinux context to its default, policy-defined state.

### Common Options:
- `-R`: Recursive.
- `-v`: Verbose.

### Example:
```bash
sudo restorecon -Rv /var/www/html
```
---

## 3. `semanage fcontext` (Manage File Contexts)

### Usage:
Defines or modifies rules for default SELinux contexts applied to files.

### Common Options:
- `-a`: Add a rule.
- `-d`: Delete a rule.
- `-m`: Modify a rule.
- `-l`: List all rules.

### Example Workflow:
1. Add a custom rule:
   ```bash
   sudo semanage fcontext -a -t httpd_sys_content_t "/custom/dir(/.*)?"
   ```
2. Apply the rule:
   ```bash
   sudo restorecon -Rv /custom/dir
   ```
3. List rules:
   ```bash
   sudo semanage fcontext -l
   ```
4. Delete a rule:
   ```bash
   sudo semanage fcontext -d "/custom/dir(/.*)?"
   ```
5. List Default Rule:
   ```bash
   sudo semanage fcontext -l
   ```

6. List Customized Rule:
   ```bash
   sudo semanage fcontext -l -C
   ```
---

## 4. SELinux Booleans (`getsebool` and `setsebool`)

SELinux Booleans allow administrators to enable or disable specific policy rules dynamically without changing the policy files.

### Common Commands:
- `getsebool`: View the current state of SELinux Booleans.
- `setsebool`: Set the value of a Boolean (temporary).
- `setsebool -P`: Set the value persistently.

### Example:
1. Check the current value of a Boolean:
   ```bash
   getsebool httpd_enable_homedirs
   ```

2. Enable `httpd_enable_homedirs` to allow HTTP servers to serve user home directories:
   ```bash
   sudo setsebool -P httpd_enable_homedirs on
   ```

3. Verify the change:
   ```bash
   getsebool httpd_enable_homedirs
   ```

---

## 5. `semanage boolean` (Manage Boolean Settings)

The `semanage boolean` command is used to list, enable, or disable SELinux Booleans persistently.

### Common Options:
- `-l`: List all Booleans with descriptions.
- `-m`: Modify a Boolean persistently.

### Example Workflow:
1. List all Booleans:
   ```bash
   sudo semanage boolean -l
   ```

2. Modify a Boolean persistently:
   ```bash
   sudo semanage boolean -m --on httpd_enable_homedirs
   ```

3. Verify the Boolean is enabled:
   ```bash
   getsebool httpd_enable_homedirs
   ```
4. Change user home in http config file 
   ```bash
   sed -i '/^UserDir.*disabled/ s/^UserDir.*disabled/UserDir public_html/' /etc/httpd/conf.d/userdir.conf
   ```bash
5. 
---

## HTTP Home Directory Example
To serve content from user home directories via an HTTP server:
1. Enable `httpd_enable_homedirs` Boolean:
   ```bash
   sudo setsebool -P httpd_enable_homedirs on
   ```
2. Ensure the user's home directory has the correct SELinux context:
   ```bash
   sudo semanage fcontext -a -t httpd_sys_content_t "/home/user/public_html(/.*)?"
   sudo restorecon -Rv /home/user/public_html
   ```
3. Verify that the HTTP server can access and serve the files:
   ```bash
   semanage boolean -l -C
   ls -Z /home/user/public_html
   ```

---

## Summary
- `chcon`: Temporary context changes.
- `restorecon`: Resets to default context.
- `semanage fcontext`: Persistent context rules.
- `getsebool`/`setsebool`: Manage Booleans dynamically.
- `semanage boolean`: Manage Boolean settings persistently.
