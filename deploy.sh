#!/usr/bin/env bash

BASEDIR=$(realpath $(dirname ${0}))

BY_FORCE=$(test "x${1}" == "x-f" && echo f || echo "")

OSNAME=$(uname -s)
if test "$(uname -o 2>/dev/null)" == "Cygwin"; then
    OSNAME=Cygwin
fi

if  test -x /usr/bin/which; then
    WHICH=/usr/bin/which
elif  test -x /bin/which; then
    WHICH=/bin/which
fi

STEP=0

TARGETS="bashrc.d zshrc.d vimrc vimrc.d"
cd ${HOME}
echo ">>> ${STEP}.  Making links ..."
for TARGET in ${TARGETS}; do
    if test ! -e "${BASEDIR}/${TARGET}"; then
        continue
    fi
    LOCAL_TARGET=.${TARGET}
    LOCAL_TARGET_ORIG=.${TARGET}.orig
    echo -n "    ${LOCAL_TARGET}: "
    if test -e "${LOCAL_TARGET}" -o -h "${LOCAL_TARGET}"; then
        if test "x${BY_FORCE}" == "xf"; then
            if test -f "${LOCAL_TARGET_ORIG}"; then
                echo -n "exists, removing ... "
                rm -rf ${LOCAL_TARGET}
            else
                echo -n "exists, rename to ${LOCAL_TARGET_ORIG} ... "
                mv ${LOCAL_TARGET} ${LOCAL_TARGET_ORIG}
            fi
        else
            echo "exists, skip"
            continue
        fi
    fi
    echo -n "making link for ${LOCAL_TARGET} ... "
    if test -f ${BASEDIR}/${TARGET}.${OSNAME}; then
        LINK_TARGET=${BASEDIR}/${TARGET}.${OSNAME}
    else
        LINK_TARGET=${BASEDIR}/${TARGET}
    fi
    if ! ln -sf ${LINK_TARGET} ${LOCAL_TARGET}; then
        exit -1
    fi
    echo "done"
done
#echo "done"
STEP=$((STEP + 1))

echo ">>> ${STEP}.  Deploying bashrc.vars ..."
if test ! -e ~/.bashrc.d/bashrc.vars -o "x${BY_FORCE}" == "xf"; then
    cp ~/.bashrc.d/bashrc.vars.sample ~/.bashrc.d/bashrc.vars
else
    echo "exists, skip"
fi
STEP=$((STEP + 1))

echo ">>> ${STEP}.  Deploying zshrc.vars ..."
if test ! -e ~/.zshrc.d/zshrc.vars -o "x${BY_FORCE}" == "xf"; then
    cp ~/.zshrc.d/zshrc.vars.sample ~/.zshrc.d/zshrc.vars
else
    echo "exists, skip"
fi
STEP=$((STEP + 1))

TARGETS="gitconfig"
cd ${HOME}
echo ">>> ${STEP}.  Making OSNAME based links ..."
for TARGET in ${TARGETS}; do
    if test ! -e "${BASEDIR}/${TARGET}"; then
        continue
    fi
    LOCAL_TARGET=.${TARGET}
    LOCAL_TARGET_ORIG=.${TARGET}.orig
    echo -n "    ${LOCAL_TARGET}: "
    if test -e "${LOCAL_TARGET}" -o -h "${LOCAL_TARGET}"; then
        if test "x${BY_FORCE}" == "xf"; then
            if test -f "${LOCAL_TARGET_ORIG}"; then
                echo -n "exists, removing ... "
                rm -rf ${LOCAL_TARGET}
            else
                echo -n "exists, rename to ${LOCAL_TARGET_ORIG} ... "
                mv ${LOCAL_TARGET} ${LOCAL_TARGET_ORIG}
            fi
        else
            echo "exists, skip"
            continue
        fi
    fi
    echo -n "making link for ${LOCAL_TARGET} ... "
    if test -f ${BASEDIR}/${TARGET}.${OSNAME}; then
        LINK_TARGET=${BASEDIR}/${TARGET}.${OSNAME}
    else
        LINK_TARGET=${BASEDIR}/${TARGET}
    fi
    if ! cp ${LINK_TARGET} ${LOCAL_TARGET}; then
        exit -1
    fi
    echo "done"
done
#echo "done"
STEP=$((STEP + 1))

echo ">>> ${STEP}.  Making additional directories need"
ADDITIONAL_DIRS="${HOME}/.tmux/plugins ${HOME}/.mutt"
for TARGET in ${ADDITIONAL_DIRS}; do
    if test ! -e "${BASEDIR}/${TARGET}"; then
        continue
    fi
    echo -n "    ${TARGET}: "
    if test ! -d ${TARGET}; then
        echo "not exists, make it"
        mkdir -p ${TARGET}
    else
        echo "exists, skip"
    fi
done
STEP=$((STEP + 1))

echo ">>> ${STEP}.  Adding personal settings to bash & ssh configurations"
for TARGET in bashrc zshrc ssh/config; do
    if test ! -e "${BASEDIR}/${TARGET}"; then
        continue
    fi
    LOCAL_TARGET=.${TARGET}
    LOCAL_TARGET_ORIG=.${TARGET}.orig
    if test "x${BY_FORCE}" == "xf"; then
        echo -n "    add/update personal settings to ${LOCAL_TARGET} BY FORCE ..."
        if test -f ${LOCAL_TARGET}; then
            cp ${LOCAL_TARGET} ${LOCAL_TARGET_ORIG}
        else
            touch ${LOCAL_TARGET_ORIG}
        fi
        (awk 'BEGIN { \
                  n = 0; found = 0; \
              } \
              /## Personal settings - begin ##/ { \
                  skip = 1; \
              } \
              { \
                  if (skip == 0) { \
                      lines[n] = $0; ++ n; \
                  } \
              } \
              /## Personal settings - end ##/ { \
                  found = 1; \
                  skip = 0; \
                  lines[n] = "## INSERT HERE ##"; \
                  ++ n; \
              } \
              END { \
                  for (i = 0; i < n; ++ i) { \
                      if (lines[i] == "## INSERT HERE ##") { \
                          while ((getline line <"'${BASEDIR}/${TARGET}'") > 0) { \
                              print line; \
                          }; \
                      } else { \
                          print lines[i]; \
                      } \
                  } \
                  if (found == 0) { \
                      while ((getline line <"'${BASEDIR}/${TARGET}'") > 0) { \
                          print line; \
                      }; \
                  } \
              }' ${LOCAL_TARGET_ORIG}) > ${LOCAL_TARGET}
        echo "done"
    elif ! grep "## Personal settings - begin ##" ${LOCAL_TARGET} >/dev/null 2>&1; then
        echo -n "    appending personal settings to ${LOCAL_TARGET} ..."
        cat ${BASEDIR}/${TARGET} >> ${LOCAL_TARGET}
        echo "done"
    else
        echo "    ${LOCAL_TARGET} has been updated before, skip"
    fi
done
#echo "done"
STEP=$((STEP + 1))

echo ">>> ${STEP}.  Installing oh-my-zsh"
if test ! -d ${HOME}/.oh-my-zsh; then
    curl -Lv https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
fi

if test $? -eq 0 -a ! -f ${HOME}/.warprc; then
    ${BASEDIR}/utils/install-zsh-plugin-wd.sh
    touch ${HOME}/.warprc
fi
STEP=$((STEP + 1))

echo ">>> ${STEP}.  Copying sample local config files"
for TARGET in $(find ${BASEDIR}/sample -type f 2>&1); do
    if test ! -e "${BASEDIR}/${TARGET}"; then
        continue
    fi
    LOCAL_TARGET=.$(basename ${TARGET})
    LOCAL_TARGET_ORIG=.$(basename ${TARGET}).orig
    if test "x${BY_FORCE}" == "xf"; then
        echo "    copying ${LOCAL_TARGET} ... BY FORCE"
        test -f ${LOCAL_TARGET} -a ! -f ${LOCAL_TARGET_ORIG} && mv ${LOCAL_TARGET} ${LOCAL_TARGET_ORIG}
        cp ${BASEDIR}/${TARGET} ~/${LOCAL_TARGET}
    elif test ! -f ${LOCAL_TARGET}; then
        echo "    copying ${LOCAL_TARGET} ..."
        cp ${BASEDIR}/${TARGET} ~/${LOCAL_TARGET}
    else
        echo "    ${LOCAL_TARGET} exists, skip"
    fi
done
#echo "done"
STEP=$((STEP + 1))

echo ">>> ${STEP}.  Installing additional softwares"
if test "${OSNAME}" = "Linux" -o "${OSNAME}" = "FreeBSD"; then
    if test -f /etc/debian_version; then
        ADDITIONAL_SOFTWARES="curl vim-nox tmux gnupg2"
        echo "    installing ${ADDITIONAL_SOFTWARES} ..."
        sudo apt update && sudo apt install -y ${ADDITIONAL_SOFTWARES}
    elif test -f /etc/redhat-release; then
        ADDITIONAL_SOFTWARES="curl vim-enhanced tmux gnupg2"
        echo "    installing ${ADDITIONAL_SOFTWARES} ..."
        sudo yum install ${ADDITIONAL_SOFTWARES}
    fi
elif test "${OSNAME}" = "Darwin"; then
    ADDITIONAL_SOFTWARES="tmux gnupg"
    echo "    installing ${ADDITIONAL_SOFTWARES} ..."
elif echo ${OSNAME} | grep -i cygwin 2>&1 >/dev/null; then
    false
fi


echo
echo ">>> All done"
echo
