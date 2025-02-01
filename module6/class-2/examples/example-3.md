# Tuned Configuration and Profile Management

## 1. Verify the tuned Package
To ensure the system tuning daemon (tuned) is installed and active:

### 1.1 Check if tuned is installed
```bash
$ dnf list tuned
```

### 1.2 Verify if tuned is enabled
```bash
$ systemctl is-enabled tuned
# Output: enabled
```

### 1.3 Check if tuned is running
```bash
$ systemctl is-active tuned
```

## 2. List Available Tuning Profiles and Active Profile
List all available tuning profiles and check the active one:
```bash
$ sudo tuned-adm list
$ sudo tuned-adm active
```

### Common Profiles:
- **balanced**: General profile balancing power and performance.
- **power-save**: Optimizes for low power consumption.
- **throughput-performance**: Maximizes system throughput.
- **virtual-guest**: Optimized for virtual machine environments.
- **network-latency**: Optimizes network performance with low latency.

## 3. Review Active Profile Configuration
Check the configuration of the active profile (e.g., `virtual-guest`):
```bash
$ cat /usr/lib/tuned/virtual-guest/tuned.conf
```

### Key Parameters:
- `vm.dirty_ratio = 30`
- `vm.swappiness = 30`

Verify applied settings:
```bash
$ sysctl vm.dirty_ratio
$ sysctl vm.swappiness
```

## 4. Review Parent Profile Configuration
The `virtual-guest` profile is based on `throughput-performance`. Check its parameters:
```bash
$ cat /usr/lib/tuned/throughput-performance/tuned.conf
```

### Key Parameters in `throughput-performance`:
- `vm.dirty_ratio = 40`
- `vm.dirty_background_ratio = 10`
- `vm.swappiness = 10`

Verify inherited settings:
```bash
$ sysctl vm.dirty_background_ratio
```

## 5. Change Active Profile
Switch to `throughput-performance` profile:
```bash
$ sudo tuned-adm profile throughput-performance
```

Verify the change:
```bash
$ sudo tuned-adm active
$ sysctl vm.dirty_ratio
$ sysctl vm.swappiness
```

By following these steps, you can effectively manage and optimize system performance using `tuned` profiles.