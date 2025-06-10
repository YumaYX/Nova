# Ansible Linux Server Provisioning

This repository contains Ansible playbooks for provisioning a Linux server with various services and configurations.

---

## Project Structure

The project is organized into several roles, each responsible for a specific set of tasks:

* **`init`**: Initializes the server, sets the hostname, configures `dnf` updates via cron, installs essential tools, and starts the **`firewalld`** service.
* **`nginx`**: Installs and configures Nginx, including setting up **`firewalld`** rules for HTTP traffic.
* **`ruby`**: Installs Ruby using **`rbenv`**, manages Ruby versions, and installs necessary gems. It also configures a daily `gem update` cron job.
* **`samba`**: Installs and configures Samba for file sharing, including **`firewalld`** rules, SELinux contexts, and Samba user management.
* **`serverspec`**: Installs Serverspec for testing, mounts a Samba share, runs tests, and then unmounts the share.
* **`user`**: Creates a specified user, configures sudo access for them, generates SSH keys, and clones/installs dotfiles from a Git repository.

---

## Roles and Their Functions

### `init`

This role performs initial setup steps on the server:

* Sets the hostname to **`lx.localdomain`**.
* Schedules a daily **`dnf -y update`** job via cron.
* Installs essential packages like **`firewalld`**, **`make`**, **`vim`**, **`jq`**, and development tools, including the "Server with GUI" group.
* Ensures **`firewalld`** is enabled and started.

### `nginx`

This role sets up the Nginx web server:

* Configures **`firewalld`** to allow HTTP traffic.
* Reloads **`firewalld`** to apply the new rules.
* Installs the **`nginx`** package.
* Restarts and enables the **`nginx`** service.

### `ruby`

This role manages Ruby installations and dependencies:

* Enables the CRB (CodeReady Linux Builder) repository.
* Installs various development packages required for Ruby and Gems (e.g., **`gcc`**, **`openssl-devel`**, **`git`**, **`rust`**).
* Clones **`rbenv`** and **`ruby-build`** into the **`prime_user`**'s home directory.
* Installs the specified Ruby version (defined in `ruby/vars/main.yml`) using **`rbenv`**.
* Updates the RubyGems system and installs a list of common gems (e.g., **`bundler`**, **`rails`**, **`sqlite3`**).
* Sets up a daily cron job to update all gems.

### `samba`

This role configures Samba for network file sharing:

* Ensures **`firewalld`** is installed, enabled, and started.
* Allows the **Samba service** through **`firewalld`** permanently.
* Installs Samba packages (**`samba`**, **`samba-common`**, **`cifs-utils`**).
* Backs up the original `smb.conf` and creates a custom one.
* Creates the `/samba/share` directory with appropriate permissions.
* Ensures the **`prime_user`** exists on the system and sets their Samba password.
* Installs SELinux tools and configures the SELinux context for the Samba share.
* Enables and restarts **`smb`** and **`nmb`** services.

### `serverspec`

This role runs Serverspec tests:

* Installs Ruby and **Serverspec**.
* Mounts the Samba share at `/mnt`.
* Navigates to the `serverspec` directory and runs Serverspec tests using **`rake`**.
* Unmounts the Samba share after tests complete.

### `user`

This role manages user-specific configurations:

* Creates the **`prime_user`** with `/bin/bash` as their shell.
* Configures **sudo access** for the **`prime_user`** using a template.
* Creates the `.ssh` directory and generates an **ED25519 SSH key** for the **`prime_user`** if one doesn't already exist.
* Ensures correct ownership and permissions for the SSH keys.
* Clones the **`dotfiles`** repository from GitHub into the **`prime_user`**'s home directory.
* Runs the **`make install`** command within the **`dotfiles`** directory.

---

## Variables

The `ruby/vars/main.yml` file defines variables specific to the Ruby role:

* **`ruby_version`**: Specifies the version of Ruby to install (e.g., **`3.4.3`**).

---

## Usage

```bash
curl -fsSL https://raw.githubusercontent.com/YumaYX/Nova/main/init.sh | sudo sh
```
