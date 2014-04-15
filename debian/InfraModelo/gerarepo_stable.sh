#! /bin/sh

apt-ftparchive generate ./conf/apt-demoiselle-ftparchive.conf 

distribuicoes="hardy lucid precise raring universal"

for dist in $distribuicoes
 do
	apt-ftparchive -c ./conf/apt-demoiselle-$dist.conf release ./repository/dists/$dist > ./repository/dists/$dist/Release
done

for dist in $distribuicoes
 do
	gpg --no-tty --yes --passphrase-file=gpg-passphrase  --default-key=XXXXXXX --sign -bao ./repository/dists/$dist/Release.gpg ./repository/dists/$dist/Release
	
done
