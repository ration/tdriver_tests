Name: testability-driver-tests
Version: 0.9.1
Release:1%{?dist}
Summary: Qt Test Automation Server Test Application
Group: Development/Tools
License: LGPL
URL: https://code.nokia.com/
Source0: %{name}-%{version}.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

BuildRequires: PackageKit-qt-devel libXtst-devel libqtwebkit-devel libX11-devel libXext-devel libXi-devel
Requires: PackageKit-qt
Requires: rubygem-cucumber
Requires: rubygem-rmagick
Requires: rubygem-testability-driver
Requires: rubygem-testability-driver-qt-sut-plugin
Requires: qttas-server qttas-server-plugins



%description
Test applications and tests for testability driver

%prep
%setup -q

%build
# TODO add CONFIG+=maemo
qmake -r 
make %{?_smp_mflags}


%install
rm -rf %{buildroot}
make install INSTALL_ROOT=%{buildroot}

%clean
rm -rf %{buildroot}


#
# Package tdriver-testapp
#

%files
%defattr(-,root,root,-)
%{_bindir}/testapp
%{_bindir}/matti_multitouchapp
%{_bindir}/calculator
%{_bindir}/calculator_runner.sh
/usr/share/testability-driver-tests/*
/usr/share/testability-driver-unit-tests/*
%{_sysconfdir}/matti/*




%changelog
* Thu Jun 17 2010 - ext-tatu.lahtela@nokia.com - 0.9.1
- Testing RPM Packaging
