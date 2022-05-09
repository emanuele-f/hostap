This repo contains a patched `wpa_supplicant` to properly connect to APs with the same MAC but on different channels.

Upstream repo: git://w1.fi/srv/git/hostap.git

## Build

Create `wpa_supplicant/.config` with the following contents:

```
CONFIG_DRIVER_NL80211=y
CONFIG_DRIVER_WEXT=y
CONFIG_IEEE8021X_EAPOL=y
CONFIG_EAP_MD5=y
CONFIG_EAP_MSCHAPV2=y
CONFIG_EAP_TLS=y
CONFIG_EAP_PEAP=y
CONFIG_EAP_TTLS=y
CONFIG_EAP_GTC=y
CONFIG_EAP_OTP=y
CONFIG_EAP_SIM=y
CONFIG_EAP_AKA=y
CONFIG_EAP_PSK=y
CONFIG_EAP_SAKE=y
CONFIG_EAP_GPSK=y
CONFIG_EAP_PAX=y
CONFIG_EAP_LEAP=y
CONFIG_EAP_IKEV2=y
CONFIG_PCSC=y
```

then

```
cd wpa_supplicant
make
```
