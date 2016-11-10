#!/bin/bash


ELVUI_DIR="/cygdrive/c/Program Files/World of Warcraft/Interface/AddOns/ElvUI/"
LATEST_VERSION=$( wget -qO- http://www.tukui.org/dl.php | grep "Latest" | grep "elvui" | grep -Po '("VIP">[0-9]*.[0-9]*)' | cut -d'>' -f2 )

if [ -f  "${ELVUI_DIR}/ElvUI.toc" ]
then
  LATEST_INSTALLED=$( cat "${ELVUI_DIR}/ElvUI.toc" | grep "Version" | cut -d' ' -f3 )
else
  LATEST_INSTALLED="unset"
fi


echo "Latest version is .....: ${LATEST_VERSION}"
echo "Latest installed is ...: ${LATEST_INSTALLED}"
echo

if [ ${LATEST_INSTALLED} != 'unset' ] && [ ${LATEST_VERSION} != ${LATEST_INSTALLED} ]
then
  echo -n "Installing newer version   -> "

  FILE_URL=$(wget -qO- http://www.tukui.org/dl.php | grep "Latest" | grep "elvui" | grep -Po "a href=\"http://www.tukui.org/downloads/elvui-${LATEST_VERSION}.zip" | sed 's/a href="//')

  echo ${FILE_URL}

  wget ${FILE_URL}
  echo "done"

  INSTALL_DIR=$( echo ${ELVUI_DIR} | sed 's/ElvUI\///' )
   
  echo "Installing ElvUI latest version into ${INSTALL_DIR}"
  unzip -u -o elvui-${LATEST_VERSION}.zip -d "${INSTALL_DIR}"

  echo "Cleanup download"
  rm elvui-${LATEST_VERSION}.zip
else
  echo "Versions match, exiting"
fi

