This repo contains a patched `wpa_supplicant` to connect to an AP on the correct channel when multiple APs share the same MAC address.

The corresponding configuration `wpa_supplicant.conf` would be:

```
network={
  ssid="Some SSID"
  psk="your_psk"
}

# connect to AP on channel 1
freq_list=2412
```

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

## Run

The `wpa_client.sh` script provides a conveninent way to connect to a WPA network on a specific channel, without the burden to create the wpa_supplicant.conf file:

```
cd wpa_supplicant

# Connect to "Some SSID" on channel 1
./wpa_client.sh wlan0 "Some SSID" my_passphrase 1
```
