# Instructions for Managing Background Processes

## Objective:
This guide demonstrates how to manage background processes in Linux, creating a script that appends arguments to a file, running processes in the background, and using signals to control those processes.

---

## Steps:

### 1. Set up two terminal windows
Open two terminal windows side by side. These terminals will be referred to as **left** and **right**.

In each terminal, use the `ssh` command to log in to the server machine as the `student` user:

```bash
[student@workstation ~]$ ssh student@servera
[student@servera ~]$
```

---

### 2. Create the necessary directory and script

#### 2.1. Create the `/home/student/bin` directory
In the left terminal, run the following command to create the `bin` directory:

```bash
[student@servera ~]$ mkdir -p /home/student/bin
```

#### 2.2. Create the `instance` script
Navigate to the `/home/student/bin` directory and create the script using the Vim editor:

```bash
[student@servera ~]$ cd /home/student/bin
[student@servera bin]$ vim instance
```

In the Vim editor, press `i` to enter insert mode. Copy and paste the following content:

```bash
#!/bin/bash
while true; do
    echo -n "$@ " >> /home/student/instance_outfile
    sleep 5
done
```

This script will run indefinitely, appending the command-line arguments passed to it every 5 seconds into the `/home/student/instance_outfile` file.

Once you've added the content, press `Esc` and type `:wq` to save and quit Vim.

#### 2.3. Make the `instance` script executable
Now, make the script executable by running:

```bash
[student@servera bin]$ chmod +x /home/student/bin/instance
```

---

### 3. Start background processes
In the left terminal, start three processes using the `instance` script. Each process will run with different command-line arguments. Start them in the background by appending `&` at the end of each command:

```bash
[student@servera bin]$ ./instance network &
[1] 3460
[student@servera bin]$ ./instance interface &
[2] 3482
[student@servera bin]$ ./instance connection &
[3] 3516
```

---

### 4. Verify that processes are appending content to the output file
Switch to the right terminal and verify that all three processes are appending content to the `/home/student/instance_outfile` file by using the `tail -f` command:

```bash
[student@servera ~]$ tail -f /home/student/instance_outfile
```

You should see output like the following as the processes continue to run and append their arguments every 5 seconds:

```
network interface network connection interface network connection interface network
```

---

### 5. List existing jobs
In the left terminal, use the `jobs` command to list the background jobs that are currently running:

```bash
[student@servera bin]$ jobs
[1] 3460 Running ./instance network &
[2] 3482 Running ./instance interface &
[3] 3516 Running ./instance connection &
```

---

### 6. Suspend a process and verify its status

#### 6.1. Suspend the `instance network` process
To suspend the `instance network` process, use the `kill` command with the `SIGSTOP` signal:

```bash
[student@servera bin]$ kill -SIGSTOP %1
+ stopped ./instance network
```

This stops the `instance network` process, and the job is now marked as `Stopped`.

#### 6.2. Verify that the process is suspended
Use the `jobs` command again to confirm the status of the jobs:

```bash
[student@servera bin]$ jobs
[1]+ 3460 Stopped ./instance network
[2] 3482 Running ./instance interface &
[3] 3516 Running ./instance connection &
```

#### 6.3. Verify that the process is no longer appending content
In the right terminal, view the output of the `tail` command to confirm that the word `network` is no longer being appended to the `/home/student/instance_outfile` file. The output should now look like this:

```
interface network connection interface network connection interface network
```

The word `network` will no longer appear in the output because the `instance network` process was suspended.

---

## Summary
- Created a directory and script to append arguments to a file every 5 seconds.
- Started multiple processes in the background with different arguments.
- Used the `kill` command to suspend a process and verified that the content was no longer appended to the output file.