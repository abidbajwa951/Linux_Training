# SELinux Overview

## What is SELinux?
**Security Enhanced Linux (SELinux)** is a powerful security feature in Linux. It enforces access control policies that govern how processes and resources (like files and ports) interact, ensuring that each process can only perform actions allowed by its specific policy.

---

## SELinux Architecture

### Key Features:
- **Granular Control:** Allows detailed management of access to files, ports, and other resources.
- **Mandatory Access Control (MAC):** SELinux enforces object-based security that cannot be bypassed by user discretion.

### Difference from Standard File Permissions:
- **File Permissions:** Control which users or groups can read, write, or execute a file.
- **SELinux Policies:** Control how files are used and accessed by processes, preventing unintended actions even by authorized users.

### Example:
With write access to a file, any program can edit it. SELinux ensures that only specific, trusted programs can write to certain files, reducing risks of data corruption or unauthorized modifications.

### Components:
- **Targeted Policies:** Application-specific policies define actions allowed for individual binaries, configuration files, and data files.
- **Labels:** SELinux uses labels (contexts) to match resources to policies, enabling controlled access.

---

## SELinux Operational Modes

SELinux operates in three distinct modes:

### 1. **Enforcing Mode**
- **Description:** Actively enforces loaded policies, denying unauthorized actions.
- **Default Mode:** Used in Red Hat Enterprise Linux (RHEL).

### 2. **Permissive Mode**
- **Description:** SELinux is active and logs violations without enforcing rules. Useful for testing and troubleshooting.

### 3. **Disabled Mode**
- **Description:** SELinux is completely disabled; no policies are loaded or enforced.
- **Note:** Disabling SELinux is **strongly discouraged**.

---

## Important Updates in RHEL 9
- SELinux can only be fully disabled by using a **kernel parameter** at boot time.
- Editing the configuration file to disable SELinux results in active enforcement without any loaded policies, effectively denying all actions.

---

## Basic SELinux Concepts

### Goals:
- Protect user data from misuse by compromised applications or services.
- Add an extra layer of security beyond traditional Discretionary Access Control (DAC).

### Labels and Contexts:
Every resource (file, process, directory, port) in SELinux has a label called a **context**, which consists of:
- **User:** Specifies the SELinux user.
- **Role:** Defines the role allowed.
- **Type:** Determines how the resource can be accessed (e.g., `httpd_t` for web server files).

### Example of Context:
For a web server, SELinux might restrict access to sensitive system directories or ports even if a user gains unauthorized access.

### Default Behavior:
- Access is **denied by default** unless explicitly allowed by a policy.

---

## Use Cases

### Example 1: Securing a Web Server
- Without SELinux:
  A web server with compromised user permissions (`httpd_user`) could expose sensitive directories like `/var/www/html` or system files.
- With SELinux:
  The server's processes are confined to access only specific labeled resources, preventing unauthorized access.

### Example 2: File Integrity
- SELinux policies ensure that only trusted programs can modify specific configuration or data files, reducing the risk of accidental or malicious corruption.

---
