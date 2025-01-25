# Configuring HTTP Web Content with SELinux

This guide explains how to set up and publish web content using SELinux, ensuring the file context is correctly configured. It also covers creating a custom directory for web content.

---

## 1. Verify and Correct SELinux File Contexts
For web content to appear on a site, the files must have the correct SELinux context, usually `httpd_sys_content_t`.

### Steps:
1. **Check File Contexts**:
   Use the `ls` command to verify the SELinux context of web content:
   ```bash
   ls -Z /var/www/html
   ```
   Files should have the `httpd_sys_content_t` context.

2. **Fix Incorrect Contexts**:
   Use `restorecon` to reset file contexts to the default policy:
   ```bash
   sudo restorecon -Rv /var/www/html
   ```

---

## 2. Create a Custom Directory for Web Content
If you want to serve web content from a directory outside `/var/www/html`, you need to configure SELinux properly.

### Steps:
1. **Create the Directory**:
   ```bash
   sudo mkdir -p /custom/webcontent
   ```

2. **Set Ownership and Permissions**:
   Assign ownership to the `apache` or `www-data` user (depending on your system):
   ```bash
   sudo chown -R apache:apache /custom/webcontent
   sudo chmod -R 755 /custom/webcontent
   ```

3. **Apply SELinux Context**:
   Assign the `httpd_sys_content_t` context to the custom directory:
   ```bash
   sudo semanage fcontext -a -t httpd_sys_content_t "/custom/webcontent(/.*)?"
   sudo restorecon -Rv /custom/webcontent
   ```

4. **Verify Context**:
   ```bash
   ls -Z /custom/webcontent
   ```
   Ensure the files and directories show the `httpd_sys_content_t` context.

---

## 3. Update Apache Configuration
Modify Apache to serve content from the custom directory.

### Steps:
1. **Edit the Apache Configuration**:
   Open the default site configuration file (e.g., `/etc/httpd/conf/httpd.conf` or `/etc/httpd/sites-enabled/000-default.conf`) and add:
   ```apache
   <Directory /custom/webcontent>
       AllowOverride None
       Require all granted
   </Directory>

   DocumentRoot "/custom/webcontent"
   ```

2. **Restart Apache**:
   ```bash
   sudo systemctl restart httpd
   ```

---

## 4. Testing the Setup
1. **Place a Test File**:
   Create an `index.html` file in the custom directory:
   ```bash
   echo "<h1>Welcome to the Custom Web Directory</h1>" > /custom/webcontent/index.html
   ```

2. **Access the Web Page**:
   Open a web browser and navigate to your server's IP address or domain. You should see the test page:
   ```
   http://<server-ip-or-domain>/
   ```

---

## Summary
- Verified and corrected SELinux contexts with `restorecon`.
- Created a custom directory for web content and applied `httpd_sys_content_t` context using `semanage`.
- Updated Apache configuration to serve the custom directory.