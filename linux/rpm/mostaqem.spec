Name:       mostaqem
Version:    1.6.4
Release:    1
Summary:    An Islamic app
License:    GNU-V3
Requires:   mpv, mpv-libs-devel
AutoReqProv: no

%define __os_install_post %{nil}

%description
An Islamic app

%prep
# no source

%build
# no source

%install
export DONT_STRIP=1
mkdir -p %{buildroot}
cp -rf linux/debian/usr/ %{buildroot}

%files
FILES_HERE

%changelog
# no changelog