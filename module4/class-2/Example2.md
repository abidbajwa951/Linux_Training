# Enabling HTTP Home Directory with SELinux Booleans and Configuration Changes

This guide walks you through enabling HTTP home directory access using SELinux Booleans, making configuration changes in Apache, and setting up the necessary file structure and permissions.

---

## 1. Enable the `httpd_enable_homedirs` SELinux Boolean
To allow the HTTP server to access user home directories, enable the `httpd_enable_homedirs` Boolean.

### Steps:
1. Check the current status of the Boolean:
   ```bash
   getsebool httpd_enable_homedirs
   ```
2. Enable the Boolean persistently:
   ```bash
   sudo setsebool -P httpd_enable_homedirs on
   ```

---

## 2. Modify Apache Configuration to Enable User Directories
Apache must be configured to allow user directories. This is controlled by the `UserDir` module and the `/etc/httpd/conf.d/userdir.conf` file.

### Steps:
1. Open the configuration file for editing:
   ```bash
   sudo vi /etc/httpd/conf.d/userdir.conf
   ```

2. Ensure the following lines are present and uncommented:
   ```apache
   UserDir public_html
   <Directory /home/*/public_html>
       AllowOverride FileInfo AuthConfig Limit Indexes
       Options MultiViews Indexes SymLinksIfOwnerMatch IncludesNoExec
       Require method GET POST OPTIONS
   </Directory>
   ```

3. Restart Apache to apply the changes:
   ```bash
   sudo systemctl restart httpd
   ```

---

## 3. Set Correct Permissions on Home Directory and `public_html`
Permissions must be configured to allow the HTTP server to access the required directories and files.

### Steps:
1. Change the permissions of the home directory to `711`:
   ```bash
   chmod 711 /home/username
   ```

2. Create the `public_html` directory inside the user's home directory:
   ```bash
   mkdir /home/username/public_html
   ```

3. Set the permissions for the `public_html` directory to `755`:
   ```bash
   chmod 755 /home/username/public_html
   ```

4. Place files to be served in the `public_html` directory:
   ```bash
   echo "<h1>Welcome to User's Home Directory!</h1>" > /home/username/public_html/index.html
   ```

---

## 4. Access the User Directory via URL
Once the configuration and permissions are set, you can access the user directory using the following URL:

```
http://<server-ip-or-domain>/~username
```

### Example:
If your server's IP address is `192.168.1.10` and the username is `john`, the URL will be:
```
http://192.168.1.10/~abid
```

---

## 5. Verify the Setup
1. Ensure SELinux contexts are correct for the `public_html` directory and its files:
   ```bash
   sudo semanage fcontext -a -t httpd_sys_content_t "/home/username/public_html(/.*)?"
   sudo restorecon -Rv /home/username/public_html
   ```

2. Check that Apache is running without errors:
   ```bash
   sudo systemctl status httpd
   ```

3. Test accessing the home directory from a web browser using the provided URL.

---

## Summary
- Enabled `httpd_enable_homedirs` Boolean for SELinux.
- Updated `/etc/httpd/conf.d/userdir.conf` to allow user directories.
- Configured directory permissions and created the `public_html` folder.
- Verified access via the URL.

