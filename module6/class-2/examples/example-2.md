# CPU Load Monitoring Instructions

## 1. Setup Workstation

### 1.1 Open Terminal Windows
On the workstation machine, open two terminal windows side by side. These terminals are referred to as **left** and **right**.

### 1.2 Log in to the Server
In each terminal, log in to the `servera` machine as the `student` user.
```bash
[student@workstation ~]$ ssh student@servera
...
[student@servera ~]$
```

## 2. Create a CPU Load Monitoring Script

### 2.1 Create the `bin` Directory
```bash
[student@servera ~]$ mkdir -p /home/student/bin
```

### 2.2 Create the `monitor` Script
Create a shell script to generate an artificial CPU load.
```bash
[student@servera ~]$ vim /home/student/bin/monitor
```
Add the following content:
```bash
#!/bin/bash
while true; do
  var=1
  while [[ $var -lt 60000 ]]; do
    var=$((var+1))
  done
  sleep 1
done
```

### 2.3 Make the Script Executable
```bash
[student@servera ~]$ chmod +x /home/student/bin/monitor
```

## 3. Monitor CPU Usage

### 3.1 Run `top` Command
In the **right** terminal:
```bash
[student@servera ~]$ top
```
Resize the window to fully view the command output.

## 4. Check CPU Information
```bash
[student@servera ~]$ lscpu
```
Look for the **CPU(s):** field to determine the number of logical CPUs.

## 5. Start the Monitor Script
Run a single instance of `monitor` in the background:
```bash
[student@servera ~]$ /home/student/bin/monitor &
[1] 6071
```

## 6. Observe CPU Load in `top`
Use keys **I**, **t**, and **m** to toggle load, threads, and memory views. Note the **PID** and CPU percentage (expected between **15-25%**).

## 7. Start Additional Instances
Run more instances to increase the CPU load.
```bash
[student@servera ~]$ /home/student/bin/monitor &
[2] 6498
[student@servera ~]$ /home/student/bin/monitor &
[3] 6881
```

Check the load averages in `top`. If the **1-minute load average** is still below 1, start additional instances:
```bash
[student@servera ~]$ /home/student/bin/monitor &
[4] 10708
[student@servera ~]$ /home/student/bin/monitor &
[5] 11122
[student@servera ~]$ /home/student/bin/monitor &
[6] 11338
```

## 8. Terminate the Monitor Processes

### 8.1 Use `top` to Kill Processes
1. In the **right** terminal, press **k**.
2. When prompted, enter the PID of a `monitor` process and press **Enter**.
3. When prompted for the signal, press **Enter** to send `SIGTERM (15)`.
4. Verify that the process has disappeared.
5. Repeat for each remaining `monitor` process.

If a process does not terminate, use:
```bash
kill -9 <PID>
```

## 9. Exit and Cleanup

### 9.1 Exit `top`
Press **q** to quit `top`.

### 9.2 Close Terminal
Exit the server connection:
```bash
[student@servera ~]$ exit
logout
Connection to servera closed.
```