[English Edition](./README.en.md)

# 类 Unix 系统中的用户设定

包含了常用的 dotfiles 以及一些常用脚本等。

适用于：

 * Linux (debian serial)
 * macOS
 * Cygwin (部分)

## 用法：

 * clone 项目后，进入目录，执行 `chmod +x deploy.sh && ./deploy.sh`
 * 如果之前已经执行过一遍，想要用最新的版本覆盖，可以用 `-f` 参数强制执行

   ```
   ./deploy.sh -f
   ```

## 说明：

### bashrc

执行 `deploy.sh` 后，调用 ~/.bashrc.d/bashrc.personal 的命令会被追加到 ~/.bashrc 文件的末尾

