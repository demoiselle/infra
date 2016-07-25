#
# spec file for package  demoiselle-2-infra-3
#

Name:		demoiselle-2-infra-3
Summary:	Dependencies for complete development environment for Demoiselle Framework 2.x
License:	Public domain
Group:		Metapackages
Version:	1.0
Release:	1.0
Requires:	demoiselle-eclipse-4.4 >= 4.4, demoiselle-maven-3 >= 3.0.5, demoiselle-maven-repo >= 3.1.0, demoiselle-workspace >= 2.0, demoiselle-tomcat-7.0 >= 7.0, demoiselle-jboss-7.1 >= 7.1.1
BuildArch:	i586
URL: 		http://demoiselle.sourceforge.net/infra
Vendor: 	Comunidade Framework Demoiselle
Packager: 	Comunidade Framework Demoiselle <demoiselle-users@lists.sourceforge.net>

%description

This meta-package privides complete development environment for Demoiselle Framework 2.x

%prep
#nothing to do

%build
#nothing to do

%install
#nothing to do

%clean
#nothing to do

%files
#nothing to do

%post 
chmod 777 -R /opt/demoiselle/

%changelog
* Mon Jul 17 2014 demoiselle-users@lists.sourceforge.net
- created

