# Running and Managing CPU-Intensive Processes on Linux

## Instructions

### 1. Log in to the Remote Server
Use the `ssh` command to connect to the `servera` machine as the `student` user:
```sh
ssh student@servera
```

### 2. Determine the Number of CPU Cores
Use the `grep` command to find the number of virtual processors (CPU cores):
```sh
grep -c 'processor' /proc/cpuinfo
```
Example output:
```sh
2
```

### 3. Start Multiple Instances of `sha1sum`
Run two instances of `sha1sum /dev/zero &` for each CPU core:
```sh
for i in {1..4}; do sha1sum /dev/zero & done
```
Example output:
```sh
[1] 1132
[2] 1133
[3] 1134
[4] 1135
```

### 4. Verify Running Processes
Check background jobs:
```sh
jobs
```
Example output:
```sh
[1] Running
[2] Running
[3] Running
[4] Running
```

### 5. Monitor CPU Usage
Use `ps` and `pgrep` to check CPU usage:
```sh
ps u $(pgrep sha1sum)
```
Example output:
```sh
PID  %CPU  COMMAND
1132 49.6  sha1sum /dev/zero
1133 49.6  sha1sum /dev/zero
1134 49.6  sha1sum /dev/zero
1135 49.6  sha1sum /dev/zero
```

### 6. Terminate All `sha1sum` Processes
Kill all `sha1sum` processes:
```sh
pkill sha1sum
```
Verify that no jobs are running:
```sh
jobs
```

### 7. Start Processes with Different Nice Levels
Start three normal instances:
```sh
for i in {1..3}; do sha1sum /dev/zero & done
```
Start one instance with a `nice` level of 10:
```sh
nice -n 10 sha1sum /dev/zero &
```

### 8. Verify Process Priorities
Check CPU usage and nice levels:
```sh
ps -o pid,pcpu,nice,comm $(pgrep sha1sum)
```
Example output:
```sh
PID   %CPU  NI  COMMAND
1207  64.2   0  sha1sum
1208  65.0   0  sha1sum
1209  63.9   0  sha1sum
1210   8.2  10  sha1sum
```

### 9. Change the Nice Level of a Process
Lower the nice level of process `1210` from 10 to 5:
```sh
sudo renice -n 5 1210
```
Example output:
```sh
1210 (process ID) old priority 10, new priority 5
```

### 10. Verify the Nice Level Change
```sh
ps -o pid,pcpu,nice,comm $(pgrep sha1sum)
```
Example output:
```sh
PID   %CPU  NI  COMMAND
1207  62.9   0  sha1sum
1208  63.2   0  sha1sum
1209  63.2   0  sha1sum
1210  10.9   5  sha1sum
```

### 11. Terminate All `sha1sum` Processes
```sh
pkill sha1sum
```

### 12. Identify and Adjust Priorities for Top CPU Consumers
Sort processes by CPU usage:
```sh
ps aux --sort=-pcpu
```
Find the nice values for the top two processes:
```sh
ps -o pid,pcpu,nice,comm $(pgrep sha1sum; pgrep md5sum)
```
Adjust the nice levels to 10:
```sh
sudo renice -n 10 <PID1> <PID2>
```
Verify the changes:
```sh
ps -o pid,pcpu,nice,comm $(pgrep sha1sum; pgrep md5sum)
```
Example output:
```sh
PID   %CPU  NI  COMMAND
1079  98.9  10  sha1sum
1095  99.2  10  md5sum
```