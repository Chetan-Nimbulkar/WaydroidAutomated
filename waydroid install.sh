export distro=bullseye

# Download GPG key with curl and check if it succeeds
sudo curl https://repo.waydro.id/waydroid.gpg --output /usr/share/keyrings/waydroid.gpg
if [ $? -ne 0 ] || [ ! -f /usr/share/keyrings/waydroid.gpg ]; then
  echo "Error: Failed to download the GPG key."
  exit 1
fi

# Add Waydroid repository
echo "deb [signed-by=/usr/share/keyrings/waydroid.gpg] https://repo.waydro.id/ ${distro} main" | \
  sudo tee /etc/apt/sources.list.d/waydroid.list

# Update package list
sudo apt-get update && sudo apt-get dist-upgrade -y

# Install required dependencies
sudo apt install -y \
  build-essential cdbs devscripts equivs fakeroot \
  git git-buildpackage git-lfs \
  libgbinder-dev

# Download build_changelog file with wget and check if it succeeds
sudo wget https://raw.githubusercontent.com/MrCyjaneK/waydroid-build/main/build_changelog \
  -O /usr/bin/build_changelog
if [ $? -ne 0 ] || [ ! -f /usr/bin/build_changelog ]; then
  echo "Error: Failed to download build_changelog."
  exit 1
fi

# Make the downloaded file executable
sudo chmod +x /usr/bin/build_changelog

# Prepare the build environment
mkdir ~/build-packages
cd ~/build-packages
git clone https://github.com/waydroid/gbinder-python

cd gbinder-python
build_changelog

# Install build dependencies and create the package
sudo mk-build-deps -ir -t "apt -o Debug::pkgProblemResolver=yes -y --no-install-recommends"
sudo debuild -b -uc -us

# Install the generated deb package
sudo apt install -f -y ../*.deb

# Clean up installed dependencies
sudo apt remove -y libgbinder-dev gbinder-python-build-deps git-lfs fakeroot equivs devscripts cdbs

# Perform autoremove to clean up unnecessary packages
sudo apt autoremove -y

# Remove the build_changelog file
sudo rm /usr/bin/build_changelog

# Install waydroid
sudo apt install waydroid -y
