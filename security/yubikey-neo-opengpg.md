# Using YubiKey Neo for PGP keys on Debian
This guide assumes that you have already configured your Yubikey Neo as a smart card with your private keys and a pin. By the end of this guide you will have configured the machine to be able to use the Yubikey to decrypt and sign documents on your machine.

## Requirements
* A Linux box
* Yubikey Neo configured as a smart card
* Internet access (to install packages and download udev rules)

## Ensure gpg2 and scdaemon is installed
``` bash
$ su -c "apt-get install gpg2 scdaemon"
$ gpg2 --version
gpg (GnuPG) 2.0.26
libgcrypt 1.6.3
Copyright (C) 2013 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Home: ~/.gnupg
Supported algorithms:
Pubkey: RSA, RSA, RSA, ELG, DSA
Cipher: IDEA, 3DES, CAST5, BLOWFISH, AES, AES192, AES256, TWOFISH,
        CAMELLIA128, CAMELLIA192, CAMELLIA256
Hash: MD5, SHA1, RIPEMD160, SHA256, SHA384, SHA512, SHA224
Compression: Uncompressed, ZIP, ZLIB, BZIP2
```

## Disable seahorse from intercepting gpg stuff
Stuff which starts on boot is stored in ```/etc/xdg/autostart```. We don't want gnome-keyring to be responsible for our gpg authentication because it can't deal with smart cards (which our yubikey neo is). After doing this you will need to log out and in again.

``` bash
su -c "mv /etc/xdg/autostart/gnome-keyring-gpg.desktop /etc/xdg/autostart/gnome-keyring-gpg.desktop.disabled"
```

## Ensure you have the udev rules for the yubikey
Your card should now work as the root user, but in order to use your Yubikey as your standard user you will need to ensure that you have the neccary udev rules added to your system. The rules you need can be obtained from the Yubikey github account. You can also install the ```yubikey-personalization``` package on Debian based distributions.

``` bash
# copy the udev rules to our downloads and then copy them (as root) to /etc/udev/rules.d to prevent wget being run as root
wget https://raw.githubusercontent.com/Yubico/yubikey-personalization/master/69-yubikey.rules -P ~/Downloads/ && su -c "mv $HOME/Downloads/69-yubikey.rules /etc/udev/rules.d/"
wget https://raw.githubusercontent.com/Yubico/yubikey-personalization/master/70-yubikey.rules -P ~/Downloads/ && su -c "mv $HOME/Downloads/70-yubikey.rules /etc/udev/rules.d/"
```

## run gpg2 --card-status to check you can see your card
I've removed most of the identifable infomation but the format should be the same. This should also create a key stub in your gpg keyring which tells gpg that in order to decrypt/sign documents using this key it will need to ask your yubikey.

``` bash
webpigeon@desktop:~# gpg2 --card-status
scdaemon[10004]: updating slot 0 status: 0x0000->0x0007 (0->1)
Application ID ...: D2760001240102000006035077540000
Version ..........: 2.0
Manufacturer .....: Yubico
Serial number ....: 00000000
Name of cardholder: Fred Bloggs
Language prefs ...: en
Sex ..............: male
URL of public key : [not set]
Login data .......: bloggsf
Signature PIN ....: forced
Key attributes ...: 2048R 2048R 2048R
Max. PIN lengths .: 127 127 127
PIN retry counter : 3 3 3
Signature counter : 00
Signature key ....: FFFF FFFF FFFF FFFF FFFF  FFFF FFFF FFFF FFFF FFFF
      created ....: 0000-00-00 00:00:00
Encryption key....: FFFF FFFF FFFF FFFF FFFF  FFFF FFFF FFFF FFFF FFFF
      created ....: 0000-00-00 00:00:00
Authentication key: FFFF FFFF FFFF FFFF FFFF  FFFF FFFF FFFF FFFF FFFF
      created ....: 0000-00-00 00:00:00
General key info..: [none]
```

## Check it worked
In order to check that we can now use our smart card to decrypt things which have been encrypted for us, we can encrypt a test document then try to decrypt it. If everything worked as we expected you should be asked for your pin when you attempt to decrypt the file. Enter your pin when prompted. The encrypted text should now be decrypted and displayed on standard out.

``` bash
echo "this is a test" | gpg2 --output test.gpg --encrypt --recipient joseph@webpigeon.me.uk
gpg2 --decrypt test.gpg
scdaemon[2119]: updating slot 0 status: 0x0000->0x0007 (0->1)
scdaemon[2119]: DBG: asking for PIN '||Please enter the PIN'
gpg: encrypted with 2048-bit RSA key, ID 033F1F3D, created 2015-05-14
      "Joseph Walton-Rivers (WebPigeon) <joseph@webpigeon.me.uk>"
this is a test
```

## Troubleshooting
### selecting openpgp failed: Card error
If you get an error when calling gpg2 --card-status you might need to reboot after adding the udev rules.
