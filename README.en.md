[中文版](./README.md)

# User profiles and dot files in Unix-like systems

Including common profiles, dotfiles, and some useful scripts.

Suitable for

 * Linux
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

After `deploy.sh` executed, original ~/.bashrc will be backed up to ~/.bashrc.orig, `bashrc` and `bashrc.d` in this project will be put into current user's home directory as symbol link, named ~/.bashrc and ~/.bashrc.d.

