[中文版](./README.md)

# User profiles and dot files in Unix-like systems

Including common profiles, dotfiles, and some useful scripts.

Suitable for

 * Linux (debian serial)
 * macOS
 * Cygwin (partly)

## Usage

 * clone with git command, Github Desktop or by other ways

   ```
   git clone https://github.com/hauzerlee/ghost-rider-skeleton.git
   cd ghost-ridher-skeleton
   chmod +x deploy.sh
   ./deploy.sh
   ```

 * if you already executed deploy.sh, but for some reason you want to execute it again full through, you can use `-f` switch like below:

   ```
   ./deploy.sh -f
   ```

## Comments

### bashrc

After `deploy.sh` executed, sourcing ~/.bashrc.d/bashrc.personal will be append to ~/.bashrc.

