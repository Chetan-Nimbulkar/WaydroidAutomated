# WaydroidAutomated

Automated Waydroid installation and dependency setup script for Kali Linux systems.

This script:

* Adds the official Waydroid repository
* Installs required build dependencies
* Builds and installs `gbinder-python`
* Cleans temporary build dependencies
* Installs Waydroid automatically

---

# Features

* Automated Waydroid repository setup
* Automatic GPG key installation
* Installs required build tools and dependencies
* Builds `gbinder-python` from source
* Cleans unnecessary packages after installation
* Minimal manual intervention

---

# Supported Systems

Tested/targeted for:

* Debian Bullseye
* Debian-based Linux distributions compatible with Bullseye repositories
* Kali linux

> This script explicitly sets:
>
> ```bash
> distro=bullseye
> ```
>
> Using it on unsupported distributions may break package dependencies.

---

# Requirements

Before running the script, ensure:

* `sudo` access
* Stable internet connection
* A supported Debian-based distribution
* Kernel support required for Waydroid

Recommended:

* Updated system
* LXC support enabled

---

# Installation

Clone the repository:

```bash
git clone https://github.com/Chetan-Nimbulkar/WaydroidAutomated.git
cd WaydroidAutomated
```

Make the script executable:

```bash
chmod +x "waydroid install.sh"
```

Run the script:

```bash
./waydroid\ install.sh
```

Or:

```bash
bash "waydroid install.sh"
```

---

# What the Script Does

## 1. Adds Waydroid Repository

Downloads and installs the official Waydroid GPG key and repository.

## 2. Updates System Packages

Runs:

```bash
sudo apt-get update
sudo apt-get dist-upgrade -y
```

## 3. Installs Build Dependencies

Installs packages required to compile `gbinder-python`.

## 4. Builds `gbinder-python`

Clones:

```text
https://github.com/waydroid/gbinder-python
```

Then:

* installs build dependencies
* builds the package
* installs generated `.deb` packages

## 5. Cleans Build Dependencies

Removes unnecessary temporary packages after installation.

## 6. Installs Waydroid

Installs the final Waydroid package automatically.

---

# Usage After Installation

Initialize Waydroid:

```bash
sudo waydroid init
```

Start the container:

```bash
sudo systemctl start waydroid-container
```

Launch Waydroid:

```bash
waydroid show-full-ui
```

---

# Troubleshooting

## Repository Key Download Fails

Check:

* internet connection
* firewall restrictions
* repository availability

---

## Build Errors

Ensure:

* package lists are updated
* required repositories are enabled
* sufficient disk space exists

---

## Waydroid Does Not Start

Verify:

* kernel supports binder modules
* LXC is functional
* Wayland session is available

---

# Warning

This script:

* performs system package upgrades
* installs repositories
* builds packages from source

Review the script before executing on production systems.

---

# License

MIT License

---

# Acknowledgements

* Waydroid Project
* MrCyjaneK
* gbinder-python contributors
